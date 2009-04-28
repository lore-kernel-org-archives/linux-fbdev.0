From: "Peter Hanzel" <hanzelpeter@gmail.com>
Subject: KMS + fb + FBIOPUT_VSCREENINFO
Date: Tue, 28 Apr 2009 10:32:34 +0200
Message-ID: <8563BBE2A1F848B3B98C1A5FAE08BD09@avitech.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753508AbZD1IcY@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello.

I have tried DRM with intel KMS and it is workiing. I am using only 
framebuffer console.
Fbcon initializes 1280x800 mode and it works like a charm.

But when I try to call FBIOPUT_VSCREENINFO on /dev/fb0, it always returns 
EINVAL,
I have checked drivers/gpu/drm/i915/intel_fb.c
and found that

intelfb_check_var        returns -EINVAL     if (var->pixclock == -1 || 
!var->pixclock)
intelfb_set_par             returns -EINVAL    if (var->pixclock != -1) { 
DRM_ERROR("PIXEL CLCOK SET\n");  return

So the FBIOPUT_VSCREENINFO always fails.

So is the change of resolution not supported through FBIOPUT_VSCREENINFO 
call?

Thanks.
