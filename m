From: Alexander Graf <agraf@suse.de>
Subject: [PATCH 1/2] Add emulation for VirtIO Frame Buffer device
Date: Mon,  2 Nov 2009 23:11:49 +0100
Message-ID: <1257199910-3197-1-git-send-email-agraf@suse.de>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws

Since Linux now understands how to talk to us graphics over VirtIO, let's
add support for it in qemu.

The good part about graphics over VirtIO is that you don't need PCI to use
it. So if there's any platform out there trying to use graphics, but not
capable of MMIO, it can use this one!

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 Makefile.target |    1 +
 hw/virtio-fb.c  |  434 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/virtio.h     |    1 +
 3 files changed, 436 insertions(+), 0 deletions(-)
 create mode 100644 hw/virtio-fb.c

diff --git a/Makefile.target b/Makefile.target
index fefd7ac..260a6a8 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -158,6 +158,7 @@ obj-y = vl.o async.o monitor.o pci.o machine.o gdbstub.o
 # virtio has to be here due to weird dependency between PCI and virtio-net.
 # need to fix this properly
 obj-y += virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o virtio-pci.o
+obj-y += virtio-fb.o
 obj-$(CONFIG_KVM) += kvm.o kvm-all.o
 obj-$(CONFIG_ISA_MMIO) += isa_mmio.o
 LIBS+=-lz
diff --git a/hw/virtio-fb.c b/hw/virtio-fb.c
new file mode 100644
index 0000000..c41d3bb
--- /dev/null
+++ b/hw/virtio-fb.c
@@ -0,0 +1,434 @@
+/*
+ * Virtio Frame Buffer Device
+ *
+ * Copyright (c) 2009 Alexander Graf <agraf@suse.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include "hw.h"
+#include "console.h"
+#include "virtio.h"
+
+#define VIRTIO_ID_FB			6
+
+typedef struct VirtIOFB
+{
+    VirtIODevice vdev;
+    DisplayState *ds;
+    VirtQueue    *vq_in;
+    VirtQueue    *vq_out;
+} VirtIOFB;
+
+/* guest -> Host commands */
+#define VIRTIO_FB_CMD_RESIZE            0x01
+#define VIRTIO_FB_CMD_FILL              0x02
+#define VIRTIO_FB_CMD_BLIT              0x03
+#define VIRTIO_FB_CMD_COPY              0x04
+#define VIRTIO_FB_CMD_WRITE             0x05
+
+/* host -> guest commands */
+#define VIRTIO_FB_CMD_REFRESH           0x81
+
+#define ROP_COPY 0
+#define ROP_XOR  1
+
+#define BITS_PER_PIXEL			32
+#define BYTES_PER_PIXEL			(BITS_PER_PIXEL / 8)
+
+struct virtio_fb_cmd {
+    uint8_t              cmd;
+    union {
+        struct {
+            uint16_t     width;
+            uint16_t     height;
+        } resize __attribute__ ((packed));
+        struct {
+            uint16_t     x;
+            uint16_t     y;
+            uint16_t     width;
+            uint16_t     height;
+        } blit __attribute__ ((packed));
+        struct {
+            uint16_t     x1;
+            uint16_t     y1;
+            uint16_t     x2;
+            uint16_t     y2;
+            uint16_t     width;
+            uint16_t     height;
+        } copy_area __attribute__ ((packed));
+        struct {
+            uint8_t      rop;
+            uint16_t     x;
+            uint16_t     y;
+            uint16_t     width;
+            uint16_t     height;
+            uint32_t     color;
+        } fill __attribute__ ((packed));
+        struct {
+            uint64_t     offset;
+            uint64_t     count;
+        } write __attribute__ ((packed));
+        uint8_t          pad[31];
+    };
+
+    uint8_t              data[];
+} __attribute__ ((packed));
+
+static VirtIOFB *to_virtio_fb(VirtIODevice *vdev)
+{
+    return (VirtIOFB *)vdev;
+}
+
+static uint32_t virtio_fb_get_features(VirtIODevice *vdev)
+{
+    return 0;
+}
+
+static int virtio_fb_send(struct VirtIOFB *s, struct virtio_fb_cmd *cmd,
+                          uint8_t *data, int len_data)
+{
+    int len_cmd = sizeof(*cmd);
+    int len_all = len_cmd + len_data;
+    VirtQueueElement elem;
+    int i = 0;
+
+    if (!virtio_queue_ready(s->vq_in))
+        return -1;
+
+    if (!virtqueue_pop(s->vq_in, &elem)) {
+        fprintf(stderr, "virtio-fb: queue lacking elements\n");
+        return -1;
+    }
+
+    if (elem.in_num < 1) {
+        fprintf(stderr, "virtio-fb: queue lacking sg's\n");
+        return -1;
+    }
+
+    if (elem.in_sg[i].iov_len < len_all) {
+        fprintf(stderr, "virtio-fb: buffer too small\n");
+        return -1;
+    }
+
+    if (len_data && !data) {
+        fprintf(stderr, "virtio-fb: passed no data but data length?!\n");
+        return -EINVAL;
+    }
+
+    memcpy(elem.in_sg[i].iov_base, cmd, len_cmd);
+    if (len_data)
+        memcpy(elem.in_sg[i].iov_base + len_cmd, data, len_data);
+
+    virtqueue_push(s->vq_in, &elem, len_all);
+    virtio_notify(&s->vdev, s->vq_in);
+
+    return 0;
+}
+
+/* QEMU display state changed, so refresh the framebuffer copy */
+static void virtio_fb_invalidate(void *opaque)
+{
+    struct VirtIOFB *s = opaque;
+    struct virtio_fb_cmd cmd;
+
+    memset(&cmd, 0, sizeof(cmd));
+    cmd.cmd = VIRTIO_FB_CMD_REFRESH;
+
+    virtio_fb_send(s, &cmd, NULL, 0);
+    dpy_update(s->ds, 0, 0, ds_get_width(s->ds), ds_get_width(s->ds));
+}
+
+static void virtio_fb_save(QEMUFile *f, void *opaque)
+{
+    VirtIOFB *s = opaque;
+
+    virtio_save(&s->vdev, f);
+}
+
+static int virtio_fb_load(QEMUFile *f, void *opaque, int version_id)
+{
+    VirtIOFB *s = opaque;
+
+    if (version_id != 1)
+        return -EINVAL;
+
+    virtio_load(&s->vdev, f);
+    return 0;
+}
+
+static void virtio_fb_handle_input(VirtIODevice *vdev, VirtQueue *vq)
+{
+}
+
+static void virtio_fb_handle_resize(VirtIOFB *s, struct virtio_fb_cmd *cmd)
+{
+    uint16_t width = tswap16(cmd->resize.width);
+    uint16_t height = tswap16(cmd->resize.height);
+
+    qemu_free_displaysurface(s->ds);
+    s->ds->surface = qemu_create_displaysurface_from(width, height,
+                        sizeof(uint32_t) * 8, width * sizeof(uint32_t),
+                        qemu_malloc(width * height * BYTES_PER_PIXEL));
+    s->ds->surface->flags |= QEMU_ALLOCATED_FLAG;
+    
+    dpy_resize(s->ds);
+
+    if (s->ds->surface->pf.bits_per_pixel != 32) {
+        fprintf(stderr, "virtio-fb only supports 32 bit ...\n");
+        exit(1);
+    }
+}
+
+static void virtio_fb_handle_fill(VirtIOFB *s, struct virtio_fb_cmd *cmd)
+{
+    uint16_t x = tswap16(cmd->fill.x);
+    uint16_t y = tswap16(cmd->fill.y);
+    uint16_t width = tswap16(cmd->fill.width);
+    uint16_t height = tswap16(cmd->fill.height);
+    uint32_t color = tswap32(cmd->fill.color);
+    uint8_t rop = cmd->fill.rop;
+
+    int ds_depth = ds_get_bytes_per_pixel(s->ds);
+    int ds_linesize = ds_get_linesize(s->ds);
+
+    uint8_t *ds_data = ds_get_data(s->ds);
+    uint32_t *src32;
+    uint8_t *src;
+    uint8_t *dst;
+
+    int i, len;
+
+    if (ds_depth != sizeof(uint32_t)) {
+        fprintf(stderr, "ds depth invalid\n");
+        exit(1);
+    }
+
+    if (rop == ROP_XOR) {
+        fprintf(stderr, "XOR\n");
+        exit(1);
+    }
+
+    if (x > ds_get_width(s->ds))
+        return;
+
+    if (y > ds_get_height(s->ds))
+        return;
+
+    if ((x + width) > ds_get_width(s->ds))
+        return;
+
+    if ((y + height) > ds_get_height(s->ds))
+        return;
+
+    len = width * ds_depth;
+    src = qemu_malloc(width * ds_depth);
+    src32 = (uint32_t *)src;
+
+    for (i = 0; i < width; i++) {
+        src32[i] = color;
+    }
+
+    dst = ds_data + (y * ds_linesize) + (x * ds_depth);
+
+    for (i = 0; i < height; i++) {
+        memcpy(dst, src, len);
+        dst += ds_linesize;
+    }
+
+    qemu_free(src);
+
+    dpy_update(s->ds, x, y, width, height);
+}
+
+static void virtio_fb_handle_blit(VirtIOFB *s, struct virtio_fb_cmd *cmd,
+                                  int len)
+{
+    uint16_t x = tswap16(cmd->blit.x);
+    uint16_t y = tswap16(cmd->blit.y);
+    uint16_t width = tswap16(cmd->blit.width);
+    uint16_t height = tswap16(cmd->blit.height);
+
+    int ds_linesize = ds_get_linesize(s->ds);
+    int ds_bpp = ds_get_bytes_per_pixel(s->ds);
+
+    int linesize = width * ds_bpp;
+    uint8_t *ds_data = ds_get_data(s->ds);
+    uint8_t *dst, *src;
+    int i;
+
+    if (x > ds_get_width(s->ds))              return;
+    if (y > ds_get_height(s->ds))             return;
+    if ((x + width) > ds_get_width(s->ds))    return;
+    if ((y + height) > ds_get_height(s->ds))  return;
+    if ((height * linesize) > len)            return;
+
+    dst = ds_data + (y * ds_linesize) + (x * ds_bpp);
+    src = cmd->data;
+
+    for (i = 0; i < height; i++) {
+        memcpy(dst, src, linesize);
+        dst += ds_linesize;
+        src += linesize;
+    }
+
+    dpy_update(s->ds, x, y, width, height);
+}
+
+static void virtio_fb_handle_copy(VirtIOFB *s, struct virtio_fb_cmd *cmd)
+{
+    uint16_t x1 = tswap16(cmd->copy_area.x1);
+    uint16_t y1 = tswap16(cmd->copy_area.y1);
+    uint16_t x2 = tswap16(cmd->copy_area.x2);
+    uint16_t y2 = tswap16(cmd->copy_area.y2);
+    uint16_t width = tswap16(cmd->copy_area.width);
+    uint16_t height = tswap16(cmd->copy_area.height);
+
+    int ds_width = ds_get_width(s->ds);
+    int ds_depth = ds_get_bytes_per_pixel(s->ds);
+    int ds_linesize = ds_get_linesize(s->ds);
+    uint8_t *ds_data = ds_get_data(s->ds);
+    uint8_t *bkp;
+    uint8_t *dst;
+    uint8_t *src;
+    int i, len;
+
+    if (ds_depth != sizeof(uint32_t)) {
+        fprintf(stderr, "ds depth invalid\n");
+        exit(1);
+    }
+
+    if (x1 > ds_get_width(s->ds))              return;
+    if (y1 > ds_get_height(s->ds))             return;
+    if (x2 > ds_get_width(s->ds))              return;
+    if (y2 > ds_get_height(s->ds))             return;
+    if ((x1 + width) > ds_get_width(s->ds))    return;
+    if ((y1 + height) > ds_get_height(s->ds))  return;
+    if ((x2 + width) > ds_get_width(s->ds))    return;
+    if ((y2 + height) > ds_get_height(s->ds))  return;
+
+    len = (ds_width * ds_depth) + (height * ds_linesize);
+    bkp = qemu_malloc(len);
+    memcpy(bkp, ds_data + (x1 * ds_depth) + (y1 * ds_linesize), len);
+
+    src = bkp;
+    dst = ds_data + (x2 * ds_depth) + (y2 * ds_linesize);
+
+    for (i = 0; i < height; i++) {
+        memcpy(dst, src, width * ds_depth);
+        dst += ds_linesize;
+        src += ds_linesize;
+    }
+
+    qemu_console_copy(s->ds, x1, y1, x2, y2, width, height);
+    dpy_update(s->ds, x2, y2, width, height);
+
+    qemu_free(bkp);
+}
+
+static void virtio_fb_handle_write(VirtIOFB *s, struct virtio_fb_cmd *cmd,
+                                   int len)
+{
+    uint64_t offset = tswap64(cmd->write.offset);
+    uint64_t count = tswap64(cmd->write.count);
+    uint8_t *ds_data = ds_get_data(s->ds);
+    int ds_width = ds_get_width(s->ds);
+    int ds_size = ds_width * ds_get_height(s->ds) * ds_get_bytes_per_pixel(s->ds);
+
+    uint16_t y1 = (offset / sizeof(uint32_t)) / ds_width;
+    uint16_t y2 = (((offset + count) / sizeof(uint32_t)) / ds_width) + 2;
+
+    if ((offset > ds_size) || (count > len))
+        return;
+
+    if ((offset + count) > ds_size)
+        count = ds_size - offset;
+
+    memcpy(ds_data + offset, cmd->data, count);
+
+    dpy_update(s->ds, 0, y1, ds_get_width(s->ds), y2 - y1);
+}
+
+static void virtio_fb_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOFB *s = to_virtio_fb(vdev);
+    VirtQueueElement elem;
+    bool notify = false;
+
+    if (!virtio_queue_ready(vq))
+        return;
+
+    while (virtqueue_pop(vq, &elem)) {
+        int d;
+        struct virtio_fb_cmd *cmd;
+        char *data, *p;
+        int data_len = 0;
+
+        for (d = 0; d < elem.out_num; d++) {
+            data_len += elem.out_sg[d].iov_len;
+        }
+
+        data = qemu_malloc(data_len);
+        p = data;
+
+        for (d = 0; d < elem.out_num; d++) {
+            memcpy(p, elem.out_sg[d].iov_base, elem.out_sg[d].iov_len);
+            p += elem.out_sg[d].iov_len;
+        }
+
+        data_len -= sizeof(*cmd);
+        cmd = (struct virtio_fb_cmd *)data;
+
+        /* We can have a text console on our display. Don't draw then */
+        if (!is_graphic_console()) {
+            goto next_item;
+        }
+
+        switch (cmd->cmd) {
+            case VIRTIO_FB_CMD_RESIZE:
+                virtio_fb_handle_resize(s, cmd);
+                break;
+            case VIRTIO_FB_CMD_FILL:
+                virtio_fb_handle_fill(s, cmd);
+                break;
+            case VIRTIO_FB_CMD_BLIT:
+                virtio_fb_handle_blit(s, cmd, data_len);
+                break;
+            case VIRTIO_FB_CMD_COPY:
+                virtio_fb_handle_copy(s, cmd);
+                break;
+            case VIRTIO_FB_CMD_WRITE:
+                virtio_fb_handle_write(s, cmd, data_len);
+                break;
+        }
+
+next_item:
+
+        qemu_free(data);
+        virtqueue_push(vq, &elem, 0);
+        notify = true;
+    }
+
+    if (notify)
+        virtio_notify(vdev, vq);
+}
+
+VirtIODevice *virtio_fb_init(DeviceState *dev)
+{
+    VirtIOFB *s;
+    s = (VirtIOFB *)virtio_common_init("virtio-fb", VIRTIO_ID_FB,
+                                       0, sizeof(VirtIOFB));
+    s->vdev.get_features = virtio_fb_get_features;
+
+    s->vq_in = virtio_add_queue(&s->vdev, 128, virtio_fb_handle_input);
+    s->vq_out = virtio_add_queue(&s->vdev, 512, virtio_fb_handle_output);
+
+    s->ds = graphic_console_init(NULL, virtio_fb_invalidate,
+                                 NULL, NULL, s);
+
+    register_savevm("virtio-fb", -1, 1, virtio_fb_save, virtio_fb_load, s);
+
+    return &s->vdev;
+}
diff --git a/hw/virtio.h b/hw/virtio.h
index 15ad910..9055f60 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -167,6 +167,7 @@ VirtIODevice *virtio_blk_init(DeviceState *dev, DriveInfo *dinfo);
 VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf);
 VirtIODevice *virtio_console_init(DeviceState *dev);
 VirtIODevice *virtio_balloon_init(DeviceState *dev);
+VirtIODevice *virtio_fb_init(DeviceState *dev);
 
 void virtio_net_exit(VirtIODevice *vdev);
 
-- 
1.6.0.2

