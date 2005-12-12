From: Andrew Morton <akpm@osdl.org>
Subject: Re: Waiting for patches in main line
Date: Mon, 12 Dec 2005 12:15:28 -0800
Message-ID: <20051212121528.5391efc6.akpm@osdl.org>
References: <439DBC27.8050909@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Elu5l-0007zp-Ke
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 12:16:13 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1Elu5j-0000bm-Gh
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 12:16:13 -0800
In-Reply-To: <439DBC27.8050909@t-online.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net

Knut Petersen <Knut_Petersen@t-online.de> wrote:
>
> It would be nice if the patches of Antonino A. Daplas could be integrated
> into main line code soon. At least those patches that fix problems in
> console rotation, panning and scrolling, and the patch that introduces the
> save_state() and restore_state() framebuffer operations.
> 

Well it's getting rather late, but if we can identify specifically which
patches are needed we can perhaps do something.

vesafb-drop-blank-hook.patch
aty-remove-unnecessary-config_pci.patch
fbdev-shift-pixel-value-before-entering-loop-in-cfbimageblit.patch
fbcon-sanitize-fbcon.patch
fbdev-fix-incorrect-unaligned-access-in-little-endian-machines.patch
nvidiafb-i2c-bus-name-beautification.patch
fbcon-store-struct-display-when-setting-all-vcs.patch
matroxfb-remove-fbconh-from-the-main-header-file.patch
savagefb-one-more-i2c-enabled-device-in-savagefb.patch
add-sysfs-entry-to-disable-framebuffer-access.patch
add-sysfs-entry-to-disable-framebuffer-access-tidy.patch
fbdev-nvidiafb-driver-cleanup.patch
fbdev-savagefb-driver-cleanup.patch
fbdev-i810fb-driver-cleanups.patch
fbdev-rivafb-driver-cleanups.patch
fbdev-asiliantfb-driver-cleanups.patch
fbdev-hgafb-convert-to-platform-device.patch
fbdev-imsttfb-driver-cleanups.patch
fbdev-kyrofb-driver-cleanups.patch
fbdev-neofb-driver-cleanups.patch
fbdev-pm2fb-driver-cleanups.patch
fbdev-tdfxfb-driver-cleanups.patch
fbdev-fbdev-cleanup.patch
fbdev-atyfb-remove-bios-less-booting.patch
fbdev-sstfb-driver-cleanups.patch
nvidiafb-fix-6xxx-7xxx-cards.patch
fbcon-add-ability-to-save-restore-graphics-state.patch
fbdev-pan-display-fixes.patch
rivafb-trim-rivafb_pan_display.patch
savagefb-trim-savagefb_pan_display.patch
vesafb-trim-vesafb_pan_display.patch
vesafb-trim-vesafb_pan_display-fix.patch
vga16fb-trim-vga16fb_pan_display.patch
fbcon-avoid-illegal-display-panning.patch
atyfb-fix-spelling.patch
atyfb-reduce-verbosity.patch
atyfb-fix-crtc_fifo_lwm-mask.patch
atyfb-fix-interlaced-modes.patch
atyfb-dont-stretch-with-crt.patch
atyfb-set-ecp-divider.patch
atyfb-improve-blanking.patch
atyfb-rage-xl-xc-cleanup.patch
atyfb-vt-gt-cleanup.patch
atyfb-lt-lg-cleanup.patch
nvidiafb-add-support-for-some-pci-e-chipsets.patch
nvidiafb-add-support-for-some-pci-e-chipsets-fix.patch
fbdev-fixing-switch-to-kd_text-enhanced-version.patch
skeletonfb-documentation-update.patch
include-video-newporth-extern-inline-static-inline.patch
fix-console-blanking.patch



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
