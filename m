From: Andrea Righi <arighi@develer.com>
Date: Sun, 06 Feb 2011 15:50:24 +0000
Subject: [PATCH] fb: fix potential deadlock between lock_fb_info and console_lock
Message-Id: <1297007424-14656-1-git-send-email-arighi@develer.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, =?UTF-8?q?Peter=20Nordstr=C3=B6m=20=28Palm=20GBU=29?= <peter.nordstrom@palm.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

The function fb_set_suspend() must be called with the console semaphore
held, which means the code path coming in here will first take the
console_lock() and then call lock_fb_info().

However several framebuffer ioctl commands acquire these locks in
reverse order (lock_fb_info() and then console_lock()). This gives rise
to potential AB-BA deadlock.

Fix this by changing the order of acquisition in the ioctl commands that
make use of console_lock().

Reported-by: Peter Nordstr=C3=B6m (Palm GBU) <peter.nordstrom@palm.com>
Signed-off-by: Andrea Righi <arighi@develer.com>
---
 drivers/video/fbmem.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index e2bf953..def59f0 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1034,14 +1034,16 @@ static long do_fb_ioctl(struct fb_info *info, unsig=
ned int cmd,
 	case FBIOPUT_VSCREENINFO:
 		if (copy_from_user(&var, argp, sizeof(var)))
 			return -EFAULT;
-		if (!lock_fb_info(info))
-			return -ENODEV;
 		console_lock();
+		if (!lock_fb_info(info)) {
+			console_unlock();
+			return -ENODEV;
+		}
 		info->flags |=3D FBINFO_MISC_USEREVENT;
 		ret =3D fb_set_var(info, &var);
 		info->flags &=3D ~FBINFO_MISC_USEREVENT;
-		console_unlock();
 		unlock_fb_info(info);
+		console_unlock();
 		if (!ret && copy_to_user(argp, &var, sizeof(var)))
 			ret =3D -EFAULT;
 		break;
@@ -1070,12 +1072,14 @@ static long do_fb_ioctl(struct fb_info *info, unsig=
ned int cmd,
 	case FBIOPAN_DISPLAY:
 		if (copy_from_user(&var, argp, sizeof(var)))
 			return -EFAULT;
-		if (!lock_fb_info(info))
-			return -ENODEV;
 		console_lock();
+		if (!lock_fb_info(info)) {
+			console_unlock();
+			return -ENODEV;
+		}
 		ret =3D fb_pan_display(info, &var);
-		console_unlock();
 		unlock_fb_info(info);
+		console_unlock();
 		if (ret =3D 0 && copy_to_user(argp, &var, sizeof(var)))
 			return -EFAULT;
 		break;
@@ -1117,14 +1121,16 @@ static long do_fb_ioctl(struct fb_info *info, unsig=
ned int cmd,
 		unlock_fb_info(info);
 		break;
 	case FBIOBLANK:
-		if (!lock_fb_info(info))
-			return -ENODEV;
 		console_lock();
+		if (!lock_fb_info(info)) {
+			console_unlock();
+			return -ENODEV;
+		}
 		info->flags |=3D FBINFO_MISC_USEREVENT;
 		ret =3D fb_blank(info, arg);
 		info->flags &=3D ~FBINFO_MISC_USEREVENT;
-		console_unlock();
 		unlock_fb_info(info);
+		console_unlock();
 		break;
 	default:
 		if (!lock_fb_info(info))
--=20
1.7.1

