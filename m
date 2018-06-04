From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 04 Jun 2018 14:14:02 +0000
Subject: Re: [PATCH 00/21] USB DisplayLink patches
Message-Id: <alpine.LRH.2.02.1806040955390.16439@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
 <CAPM=9twz_g6xw_C_XdNsB7nhx3-5iy4=AoxR1NadTfA+Xy-S5g@mail.gmail.com>
In-Reply-To: <CAPM=9twz_g6xw_C_XdNsB7nhx3-5iy4=AoxR1NadTfA+Xy-S5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Ladislav Michl <ladis@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>, dri-devel <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>



On Mon, 4 Jun 2018, Dave Airlie wrote:

> On 4 June 2018 at 00:40, Mikulas Patocka <mpatocka@redhat.com> wrote:
> > Hi
> >
> > Here I'm sending bug fixes and performance improvements for the USB
> > DisplayLink framebuffer and modesetting drivers for this merge window.
> >
> 
> Hi,
> 
> You probably want to split these up into separate series for the kms and fbdev
> drivers.
> 
> Otherwise at least for drm you've missed this merge window, since it
> closes around rc6 of the previous kernel,

Could you apply at least the fbdefio patches (without them, fbdefio is 
unusable due to crashes) and the display corruption of the last line 
(because most people will hit it)?

> did you use git send-email
> for these patches, at least some of them viewed funny on my phone,

I used the command "quilt mail". I use quilt, not git, for management of 
my patches.

> I'll try and look over the kms ones soon. Do you have any numbers for
> improvements to the kms ones?
> 
> Dave.

I measured performance improvement on the framebuffer patches. The kms 
driver already performs well, there's not much to do.

I'd like to as you if you could review the patch "udl-kms: fix a 
linked-list corruption when using fbdefio" - for me it fixes the crashes, 
but I am not expert in modesetting drivers and I don't know if some other 
part of the kernel assumes that the framebuffer pages must be allocated 
with drm_gem_get_pages.


BTW. When I unplug the USB adapter while using the modesetting driver, I 
get this warning. Do you have an idea how to fix it?

WARNING: CPU: 0 PID: 61 at drivers/gpu/drm/drm_mode_config.c:439 drm_mode_config_cleanup+0x250/0x2b8 [drm]
Modules linked in: udlfb hid_generic usbhid hid tun bridge stp llc autofs4 binfmt_misc ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipt_REJECT nf_reject_ipv4 xt_conntrack xt_multiport iptable_filter iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_nat xt_tcpudp iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 ip_tables x_tables pppoe pppox af_packet ppp_generic slhc udl drm_kms_helper cfbfillrect cfbimgblt cfbcopyarea drm drm_panel_orientation_quirks syscopyarea sysfillrect sysimgblt fb_sys_fops fb font snd_usb_audio snd_hwdep snd_usbmidi_lib snd_rawmidi snd_pcm snd_timer snd soundcore nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack sd_mod ipv6 aes_ce_blk crypto_simd cryptd aes_ce_cipher crc32_ce ghash_ce gf128mul aes_arm64 sha2_ce
 sha256_arm64 sha1_ce xhci_plat_hcd xhci_hcd sha1_generic usbcore usb_common ahci_platform libahci_platform libahci mvpp2 unix
CPU: 0 PID: 61 Comm: kworker/0:2 Not tainted 4.17.0-rc7 #1
Hardware name: Marvell 8040 MACCHIATOBin (DT)
Workqueue: usb_hub_wq hub_event [usbcore]
pstate: 80000005 (Nzcv daif -PAN -UAO)
pc : drm_mode_config_cleanup+0x250/0x2b8 [drm]
lr : drm_mode_config_cleanup+0x88/0x2b8 [drm]
sp : ffffffc13a643920
x29: ffffffc13a643920 x28: ffffffc13a63ac00
x27: ffffffc1380962c0 x26: ffffffc11b95f898
x25: ffffff8000afd1d8 x24: ffffffc11b95f800
x23: 0000000000000060 x22: ffffff8000afd240
x21: ffffffc11b95eb38 x20: ffffffc11b95e800
x19: ffffffc11b95eb30 x18: ffffffc11b95ea7c
x17: 0000007fa3591b60 x16: ffffff80081dc178
x15: ffffffc11b95ea78 x14: 0000000000000000
x13: ffffffc12b3fc000 x12: ffffffc12b3fc028
x11: ffffffc12b3fc119 x10: 000000000000001f
x9 : 0000000000000028 x8 : ffffff8000a84000
x7 : 0000000000000000 x6 : 0000000000000001
x5 : 0000000000000002 x4 : 0000000000000001
x3 : 0000000000000002 x2 : 000000000000002f
x1 : ffffffc11b95eaf8 x0 : ffffffc11b978818
Call trace:
 drm_mode_config_cleanup+0x250/0x2b8 [drm]
 udl_modeset_cleanup+0xc/0x18 [udl]
 udl_driver_unload+0x30/0x50 [udl]
 drm_dev_unregister+0x3c/0xe8 [drm]
 drm_dev_unplug+0x18/0x70 [drm]
 udl_usb_disconnect+0x30/0x40 [udl]
 usb_unbind_interface+0x6c/0x290 [usbcore]
 device_release_driver_internal+0x170/0x200
 device_release_driver+0x14/0x20
 bus_remove_device+0x118/0x128
 device_del+0x110/0x308
 usb_disable_device+0x8c/0x1f8 [usbcore]
 usb_disconnect+0xb4/0x218 [usbcore]
 usb_disconnect+0x9c/0x218 [usbcore]
 usb_disconnect+0x9c/0x218 [usbcore]
 hub_event+0xf20/0x1020 [usbcore]
 process_one_work+0x1c8/0x310
 worker_thread+0x44/0x450
 kthread+0x118/0x120
 ret_from_fork+0x10/0x18
---[ end trace 978a27ff198f1268 ]---
[drm:drm_mode_config_cleanup [drm]] *ERROR* connector DVI-I-1 leaked!

Mikulas
