From: "Mitsuhiro KOGA" <shiena.jp@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4] sisusbvga: fix sisusb.c
Date: Wed, 16 Aug 2006 20:31:09 +0900
Message-ID: <6cb5f1c10608160431w1b294780yee3404a779da38ff@mail.gmail.com>
References: <6cb5f1c10608131347s69e2c1adgf0a72041314d6bf0@mail.gmail.com>
	<1155600551.3917.25.camel@daplas.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GDJc8-0006IX-3N for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Aug 2006 04:31:12 -0700
Received: from nf-out-0910.google.com ([64.233.182.190])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GDJc7-00078F-CK
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Aug 2006 04:31:12 -0700
Received: by nf-out-0910.google.com with SMTP id l36so572716nfa
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 Aug 2006 04:31:09 -0700 (PDT)
In-Reply-To: <1155600551.3917.25.camel@daplas.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: akpm@osdl.org, thomas@winischhofer.net, linux-fbdev-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net

Hi,

> It would be better if you remove the #ifdef within the functions.
> So something like...
>
<snip>

> #ifdef __LITTLE_ENDIAN
> static inline void sisusb_memcpy(void *d, void *s, int count)
> {
>         memcpy(d, s, count);
> }
> #else
> static inline void sisusb_memcpy(void *d, void *s, int count)
> {
>         memcpy_and_reverse(d, s, count);
> }
> #endif
>

<snip>

>
> And for the above 2, something like...
>
> #ifdef __BIG_ENDIAN
> static inline void sisusb_reverse(u32 *s, u32 *d)
> {
>         *d = ((*s << 16) & 0xffff0000) | ((*s >> 16) & 0xffff);
> }
> #else
> static inline void sisiusb_reverse(u32 *s, u32 *d)
> {
>         *d = *s;
> }
> #endif

Thanks.
I re-fixed the patch according to your advice.
And, because it's used #ifdef in other part, I also fixed it.
Would you please check it?

Signed-off-by: Mitsuhiro Koga <shiena.jp@gmail.com>
---
diff -urp a/drivers/usb/misc/sisusbvga/sisusb.c
b/drivers/usb/misc/sisusbvga/sisusb.c
--- a/drivers/usb/misc/sisusbvga/sisusb.c	2006-08-07 03:20:11.000000000 +0900
+++ b/drivers/usb/misc/sisusbvga/sisusb.c	2006-08-16 15:53:59.000000000 +0900
@@ -76,6 +76,63 @@ static struct usb_driver sisusb_driver;

 DEFINE_MUTEX(disconnect_mutex);

+#ifdef __BIG_ENDIAN
+static inline void sisusb_memcpy(u16 *dst, u16 *src, int count)
+{
+	while (count--)
+		*(dst++) = cpu_to_le16(*(src++));
+}
+#else
+static inline void sisusb_memcpy(u16 *dst, u16 *src, int count)
+{
+	memcpy(dst, src, count);
+}
+#endif
+
+#ifdef __BIG_ENDIAN
+static inline void sisusb_order_wmem_24bit(char *src, u32 *dst)
+{
+	*dst = (*src        << 16) |
+		(*(src + 1) <<  8) |
+		*(src + 2);
+}
+#else
+static inline void sisusb_order_wmem_24bit(char *src, u32 *dst)
+{
+	*dst = (*(src + 2)  << 16) |
+		(*(src + 1) <<  8) |
+		*src;
+}
+#endif
+
+#ifdef __BIG_ENDIAN
+static inline void sisusb_order_rmem_24bit(u32 *src, char *dst)
+{
+	*dst       = (*src >> 16) & 0xff;
+	*(dst + 1) = (*src >> 8)  & 0xff;
+	*(dst + 2) = *src         & 0xff;
+}
+#else
+static inline void sisusb_order_rmem_24bit(u32 *src, char *dst)
+{
+	*(dst + 2) = (*src >> 16) & 0xff;
+	*(dst + 1) = (*src >> 8)  & 0xff;
+	*dst       = *src         & 0xff;
+}
+#endif
+
+#ifdef __BIG_ENDIAN
+static inline void sisusb_order_mem_32bit(u32 *src, u32 *dst)
+{
+	*dst = ((*src << 16) & 0xffff0000) | ((*src >> 16) & 0xffff);
+}
+#else
+static inline void sisusb_order_mem_32bit(u32 *src, u32 *dst)
+{
+	*dst = *src;
+}
+#endif
+
 static void
 sisusb_free_buffers(struct sisusb_usb_data *sisusb)
 {
@@ -408,7 +465,11 @@ static int sisusb_send_bulk_msg(struct s

 		} else if (fromkern) {

-			memcpy(buffer, kernbuffer, passsize);
+			if ((len & 3) == 0)
+				sisusb_memcpy((u16 *)buffer, (u16 *)kernbuffer, passsize / 2);
+			else
+				memcpy(buffer, kernbuffer, passsize);
+
 			kernbuffer += passsize;

 		}
@@ -872,25 +933,9 @@ static int sisusb_write_mem_bulk(struct
 			if (userbuffer) {
 				if (copy_from_user(&buf, userbuffer, 3))
 					return -EFAULT;
-#ifdef __BIG_ENDIAN
-				swap32 = (buf[0] << 16) |
-					 (buf[1] <<  8) |
-					 buf[2];
-#else
-				swap32 = (buf[2] << 16) |
-					 (buf[1] <<  8) |
-					 buf[0];
-#endif
+				sisusb_order_wmem_24bit(&buf, &swap32);
 			} else
-#ifdef __BIG_ENDIAN
-				swap32 = (kernbuffer[0] << 16) |
-					 (kernbuffer[1] <<  8) |
-					 kernbuffer[2];
-#else
-				swap32 = (kernbuffer[2] << 16) |
-					 (kernbuffer[1] <<  8) |
-					 kernbuffer[0];
-#endif
+				sisusb_order_wmem_24bit(kernbuffer, &swap32);

 			ret = sisusb_write_memio_24bit(sisusb,
 							SISUSB_TYPE_MEM,
@@ -907,7 +952,7 @@ static int sisusb_write_mem_bulk(struct
 				if (get_user(swap32, (u32 __user *)userbuffer))
 					return -EFAULT;
 			} else
-				swap32 = *((u32 *)kernbuffer);
+				sisusb_order_mem_32bit((u32 *)kernbuffer, &swap32);

 			ret = sisusb_write_memio_long(sisusb,
 							SISUSB_TYPE_MEM,
@@ -1227,15 +1272,7 @@ static int sisusb_read_mem_bulk(struct s
 								addr, &swap32);
 			if (!ret) {
 				(*bytes_read) += 3;
-#ifdef __BIG_ENDIAN
-				buf[0] = (swap32 >> 16) & 0xff;
-				buf[1] = (swap32 >> 8) & 0xff;
-				buf[2] = swap32 & 0xff;
-#else
-				buf[2] = (swap32 >> 16) & 0xff;
-				buf[1] = (swap32 >> 8) & 0xff;
-				buf[0] = swap32 & 0xff;
-#endif
+				sisusb_order_rmem_24bit(&swap32, &buf[0]);
 				if (userbuffer) {
 					if (copy_to_user(userbuffer, &buf[0], 3))
 						return -EFAULT;
@@ -1259,7 +1296,7 @@ static int sisusb_read_mem_bulk(struct s

 					userbuffer += 4;
 				} else {
-					*((u32 *)kernbuffer) = swap32;
+					sisusb_order_mem_32bit((u32 *)kernbuffer, &swap32);
 					kernbuffer += 4;
 				}
 				addr += 4;
@@ -3435,6 +3472,9 @@ static void sisusb_disconnect(struct usb

 static struct usb_device_id sisusb_table [] = {
 	{ USB_DEVICE(0x0711, 0x0900) },
+	{ USB_DEVICE(0x0711, 0x0901) },
+	{ USB_DEVICE(0x0711, 0x0902) },
+	{ USB_DEVICE(0x0711, 0x0920) },
 	{ USB_DEVICE(0x182d, 0x021c) },
 	{ USB_DEVICE(0x182d, 0x0269) },
 	{ }

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
