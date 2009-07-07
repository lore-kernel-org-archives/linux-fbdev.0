From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH 1/4] [ARM] s3c-fb: Fix an off-by-one error at window release
Date: Tue, 07 Jul 2009 12:23:02 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC076E71C42A@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: "adaplas@gmail.com" <adaplas@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Pawel Osciak <p.osciak@samsung.com>

    
This bug caused the release function being called on the first
uninitialized window, instead of starting with the last successfully
initialized one.    

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>



diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index bb63c07..ff0b1a3 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -926,7 +926,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 		ret = s3c_fb_probe_win(sfb, win, &sfb->windows[win]);
 		if (ret < 0) {
 			dev_err(dev, "failed to create window %d\n", win);
-			for (; win >= 0; win--)
+			for ( win = win - 1; win >= 0; win--)
 				s3c_fb_release_win(sfb, sfb->windows[win]);
 			goto err_ioremap;
 		}

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
