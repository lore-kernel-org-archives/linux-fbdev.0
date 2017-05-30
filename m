From: Sinclair Yeh <syeh@vmware.com>
Date: Tue, 30 May 2017 15:17:19 +0000
Subject: Re: [bug report] drm/vmwgfx: Cursor not visible in VMware in 4.11+ kernel
Message-Id: <MWHPR05MB3296B6DB061E3C02E9E531C2A8F00@MWHPR05MB3296.namprd05.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <D552E12B.17F31%Andrew.Boyer@emc.com>
In-Reply-To: <D552E12B.17F31%Andrew.Boyer@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi,

Please apply this patch to your tree.  This patch is queue for our next pul=
l request.

https://cgit.freedesktop.org/mesa/vmwgfx/commit/?id=3D324722b1e1582d45e865d=
cd2233a17edcfbd1638

Sinclair


________________________________________
From: Boyer, Andrew <Andrew.Boyer@emc.com>
Sent: Tuesday, May 30, 2017 5:43 AM
To: linux-fbdev@vger.kernel.org
Cc: Sinclair Yeh
Subject: [bug report] drm/vmwgfx: Cursor not visible in VMware in 4.11+ ker=
nel

Hello linux-fbdev,
My apologies if this is misdirected.

vmwgfx appears to be unhappy on my systems with kernels newer than the
v4.11 tag. These are CentOS7 VMs running under ESXi 6.5. I=B9m viewing them
with the VMware Fusion remote console on a Mac.

The problem is that the cursor is either invisible or a very small circle.
There are repeated messages like this in the log:

[316850.789932] [drm:vmw_kms_fb_create [vmwgfx]] *ERROR* failed to create
vmw_framebuffer: -22
[316850.795899] [drm:vmw_kms_new_framebuffer [vmwgfx]] *ERROR* Invalid
surface format for requested mode.
[316850.802550] [drm:vmw_kms_fb_create [vmwgfx]] *ERROR* failed to create
vmw_framebuffer: -22
[316850.832484] [drm:vmw_kms_new_framebuffer [vmwgfx]] *ERROR* Invalid
surface format for requested mode.
[316850.841144] [drm:vmw_kms_fb_create [vmwgfx]] *ERROR* failed to create
vmw_framebuffer: -22
[316850.924657] [drm:vmw_kms_new_framebuffer [vmwgfx]] *ERROR* Invalid
surface format for requested mode.
[316850.932364] [drm:vmw_kms_fb_create [vmwgfx]] *ERROR* failed to create
vmw_framebuffer: -22
[316851.690965] [drm:vmw_kms_new_framebuffer [vmwgfx]] *ERROR* Invalid
surface format for requested mode.
[316851.697526] [drm:vmw_kms_fb_create [vmwgfx]] *ERROR* failed to create
vmw_framebuffer: -22
[316851.710114] [drm:vmw_kms_new_framebuffer [vmwgfx]] *ERROR* Invalid
surface format for requested mode.
[316851.716641] [drm:vmw_kms_fb_create [vmwgfx]] *ERROR* failed to create
vmw_framebuffer: -22
[316853.489526] [drm:vmw_kms_new_framebuffer [vmwgfx]] *ERROR* Invalid
surface format for requested mode.
[316853.498164] [drm:vmw_kms_fb_create [vmwgfx]] *ERROR* failed to create
vmw_framebuffer: -22
[316853.813480] [drm:vmw_kms_new_framebuffer [vmwgfx]] *ERROR* Invalid
surface format for requested mode.
[316853.821187] [drm:vmw_kms_fb_create [vmwgfx]] *ERROR* failed to create
vmw_framebuffer: -22
[316854.054016] [drm:vmw_kms_new_framebuffer [vmwgfx]] *ERROR* Invalid
surface format for requested mode.


The problems disappear if I revert back to the 4.11 kernel. There are no
changes in my kernel that would affect this (only SCSI and RDMA stuff).

I don=B9t know anything at all about graphics driver development, so I=B9m =
not
sure where else to go. None of the recent commits to driver/gpu/drm/vmwgfx
look suspicious to me.

Thank you,
Andrew

P.S. From the log:
[    2.014419] [drm] DMA map mode: Using physical TTM page addresses.
[    2.014694] [drm] Capabilities:
[    2.014698] [drm]   Rect copy.
[    2.014700] [drm]   Cursor.
[    2.014702] [drm]   Cursor bypass.
[    2.014704] [drm]   Cursor bypass 2.
[    2.014705] [drm]   8bit emulation.
[    2.014707] [drm]   Alpha cursor.
[    2.014709] [drm]   Extended Fifo.
[    2.014711] [drm]   Multimon.
[    2.014712] [drm]   Pitchlock.
[    2.014714] [drm]   Irq mask.
[    2.014716] [drm]   Display Topology.
[    2.014718] [drm]   GMR.
[    2.014720] [drm]   Traces.
[    2.014721] [drm]   GMR2.
[    2.014723] [drm]   Screen Object 2.
[    2.014724] [drm]   Command Buffers.
[    2.014724] [drm]   Command Buffers 2.
[    2.014724] [drm]   Guest Backed Resources.
[    2.014725] [drm]   DX Features.
[    2.014725] [drm] Max GMR ids is 64
[    2.014726] [drm] Max number of GMR pages is 65536
[    2.014782] [drm] Max dedicated hypervisor surface memory is 0 kiB
[    2.014782] [drm] Maximum display memory size is 16384 kiB
[    2.014782] [drm] VRAM at 0xe8000000 size is 4096 kiB
[    2.014784] [drm] MMIO at 0xfe000000 size is 256 kiB
[    2.014787] [drm] global init.
[    2.014858] [TTM] Zone  kernel: Available graphics memory: 3956522 kiB
[    2.014861] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    2.014863] [TTM] Initializing pool allocator
[    2.014870] [TTM] Initializing DMA pool allocator
[    2.015212] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.015215] [drm] No driver support for vblank timestamp query.
[    2.015586] [drm] Screen Target Display device initialized
[    2.015661] [drm] width 800
[    2.015681] [drm] height 480
[    2.015700] [drm] bpp 32
[    2.016726] vmxnet3 0000:13:00.0 eth1: NIC Link is Up 10000 Mbps
[    2.017006] [drm] Fifo max 0x00040000 min 0x00001000 cap 0x0000077f
[    2.018019] [drm] Using command buffers with DMA pool.
[    2.018031] [drm] DX: no.
[    2.018033] [drm] Atomic: yes
