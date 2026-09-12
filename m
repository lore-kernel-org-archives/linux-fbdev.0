Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527E3A8737
	for <linux-fbdev@vger.kernel.org>; Sat, 12 Sep 2026 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789247726; cv=none; b=rzmHYtHFQmsFFszFh3+INbLRM5Vhr6jxx+9B8exFfkpTi+lmhWEOM89OjOP1/tdF3IaAg+FA+67eu/gdUrOxcWoe21In6rwQ3hL7Rmr67hGCO3pyfxDG+j+9eUECydevyKW1JhfPtg4Yo3CMJm3KSzxMHTAONw/UejyP9vpuq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789247726; c=relaxed/simple;
	bh=pgLeJ7lbYd/VmJJyHy7zS6Ae3vYXECbsVtUpoN4gxKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePaQSWmgTSUWZyKyKjT+Em5tAUPFluP4Ip6p+M/pcdG+mBHOgiSDM5B8BbTd+ixbPMT/5a6lFctIZ1eOOBqYqdT+S/1cffvlQbyu2ADvOPCTQ9b55OCwMl0ihpFByJ/jrLQ+hpFrlS7fEDMzwzZvR9D2DBzDcwffu8QFTBvJUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=MaHgSS13; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="MaHgSS13"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4c3eeefdf2bso1902670b6e.1
        for <linux-fbdev@vger.kernel.org>; Sat, 12 Sep 2026 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789247716; x=1789852516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jn+jkXZgmdqQdeTiGXA67KlphU8PH0hw9LcDIFI9mXU=;
        b=MaHgSS13XzwrZKp8JkPlWnkILeagBN1XIzJ2gmqGL516gplI1A+PatW2SrHKOii+0I
         uaxPxv1euZ+NaLHp6X2SoCxnk0GbjmvsXaY3oEaLKR8O1/hV/iG/zVr0NHtCKRAtMHBJ
         f81+mKas58R7cGZSMTuP/H3tPFYC2belLpnwB4L5ewbJPfaPjtwyTucnEsxFNoyxEPzk
         l94/sSLodoa7olsFB61LUcoAzR3nRIeYLKmlxuizvU/8if5UADtNRMEh3djXokqgsrNT
         qU7fUj54CfMHs5oixXqp6rjnlpS3mntlKMocoYvjfzul49sgMKYxoR9BXSPDoUK9mJvt
         sn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789247716; x=1789852516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jn+jkXZgmdqQdeTiGXA67KlphU8PH0hw9LcDIFI9mXU=;
        b=dSC6nkdDOwpTSz3khr2Zz//v4Bw54G5jekCe7/xC0V9C+2vqV+5oANM1yZwn/80+1b
         6nkPNHn5AhVXNzHypUF4HspS6V/UN1w1IfJeYFdFohGJXtIe/zx1Q1CzrjRrE+pevqZe
         vXfEa+upzb/jHxcEYlGKWQl4O8RMi2c3iuO3xgtInp16bJDSF0ym76+ao1jsLbkUXuqL
         6RIBEYR3z9YkeJdVJIdA4loFtVVYPQcib5s1VoRvH1ybAEgkHR81IriDt6iK3SLSXcWY
         69jVp+yC4iNEQVzoyLnK2at+waMxWUp2G/BaAGodZzeILFeEeqdFjbXaUsJna5yvp1Nc
         QqPg==
X-Forwarded-Encrypted: i=1; AKwUvBwIyWXaxBnN4L8U3JgPfqReOahKp7pCsc4L+kQFWB401ragfu/9pw7CmKpz24ffSzOLOyi5L9kjNTukFA==@vger.kernel.org
X-Gm-Message-State: AFuF++mbfsJszosHtr4dtgTcUFmq1Md0xX0zxDZthNQ6clx2jFVAB92z
	659SV3W0DP/D7phDJv/h3yNn12KSW25u9ZccfSVkLdXJ1/Axf8s/PbaF2WKtefy/Lg==
X-Gm-Gg: AYBFou3vv76+LOCsK+ZWAtiT7lfZ4dYsJnxKuVHpoJq2SQEIpMUBvGkzFnv/AdIbOq2
	vN7eeH3Bs0DJpVzIdw047BdNgiIUA1Ptrwjqis2IFKEeLGhI19+IgEewpWLIYzfZiY6bkmJGKcd
	N+9GIJQQM8RE/+5tFCcxtHR2ymDqFhoNgOnJwN7MyN+r/Oo6l5cGb2Kxwfn9jtF8ZkfEj8AVZfi
	yfxtbhjt+kQtz0LFONWl7wYFlkJVlul5VMsaohwh+1NVHmFadtekLW/sArmng2MkgY8hVDslo4J
	Q6srvYzKtQQR/LSNuCdtys21Cwi9HNaBjAUW3BqYo1fwKuGPNn5zNoOPjDM+th1IIlbxsjuJLG+
	kA/6BWPSzeMOG9o6hy85WicFxxhZg5s5DH3n2Tpl445WpDbt8eyKqDvmBBqOU8ABBKvfFX3NQm8
	kuBo2fu1kZWujc2rgwl75cDdRCzndnIYjV4+PERSCx6c7TeRaO2fKivoXGcBF0GGJR0RMf9MEBU
	ozHZN7auVbXlajuwv+hyJaDYcQRNQfBr/3t/b34sMkdGsRRYA==
X-Received: by 2002:a05:6808:2224:b0:4c3:cd49:bbf7 with SMTP id 5614622812f47-4c3cd49bf95mr7236782b6e.42.1789247716315;
        Sat, 12 Sep 2026 14:15:16 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c331bc937bsm6003521b6e.11.2026.09.12.14.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 14:15:15 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: bernie@plugable.com,
	deller@gmx.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: gregkh@linuxfoundation.org,
	co+ed9902f2e44184d9@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: udlfb: don't rebuild the mode list while the framebuffer is in use
Date: Sat, 12 Sep 2026 14:15:12 -0700
Message-ID: <20260912211512.2049147-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dlfb_setup_modes() frees info->modelist with fb_destroy_modelist() and
rebuilds it, but fbcon holds raw pointers into that list in
fb_display[i].mode and nothing un-publishes them the way
do_unregister_framebuffer() and store_modes() do with
fbcon_delete_modelist(). The function does refuse to install a new mode
while the framebuffer has users (dlfb->fb_count != 0), but only after the
list is already destroyed. Reached from the 0666 "edid" sysfs attribute,
an unprivileged write to /sys/class/graphics/fb0/edid therefore fails with
-EINVAL and still leaves every fb_display[i].mode dangling; the next
console switch reads the freed fb_videomode in fb_videomode_to_var().

Test fb_count before touching the list. fbcon takes a reference through
fbcon_open(), so that condition covers exactly the states in which
fb_display[] points into the list, and the errno returned to userspace is
unchanged.

  BUG: KASAN: slab-use-after-free in fb_videomode_to_var (drivers/video/fbdev/core/modedb.c:905)
  Read of size 4 at addr ffff8880107b449c by task kworker/1:1/47
  Workqueue: events console_callback
  Call Trace:
   fb_videomode_to_var (drivers/video/fbdev/core/modedb.c:905)
   display_to_var (drivers/video/fbdev/core/fbcon.c:998)
   fbcon_switch (drivers/video/fbdev/core/fbcon.c:2182)
   redraw_screen (drivers/tty/vt/vt.c:994)
   complete_change_console (drivers/tty/vt/vt_ioctl.c:1141)
   console_callback (drivers/tty/vt/vt.c:3358)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  ...
  The buggy address is located 28 bytes inside of
   freed 96-byte region [ffff8880107b4480, ffff8880107b44e0)

Cc: stable@vger.kernel.org
Fixes: 7d9485e2c53c ("Staging: udlfb: Add functions to expose sysfs metrics and controls")
Reported-by: co+ed9902f2e44184d9@bugs.sh
Closes: https://lore.kernel.org/all/1jSCSNaDKmuUG7h40rTsSl1rMaSwdlJef4rp%40bugs.sh/
Assisted-by: Claude:claude-opus-5
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/video/fbdev/udlfb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index e78d6f95c9c5..92b352bc7e96 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1293,6 +1293,11 @@ static int dlfb_setup_modes(struct dlfb_data *dlfb,
 		goto error;
 	}
 
+	if (dlfb->fb_count) {
+		result = -EINVAL;
+		goto error;
+	}
+
 	fb_destroy_modelist(&info->modelist);
 	memset(&info->monspecs, 0, sizeof(info->monspecs));
 
-- 
2.43.0

