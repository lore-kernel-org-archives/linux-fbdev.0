Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D20C77B75
	for <linux-fbdev@archiver.kernel.org>; Fri, 19 May 2023 19:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjESTce (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 19 May 2023 15:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjESTcd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 19 May 2023 15:32:33 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9CB3D13D
        for <linux-fbdev@vger.kernel.org>; Fri, 19 May 2023 12:32:31 -0700 (PDT)
Received: (qmail 49206 invoked by uid 1000); 19 May 2023 15:32:30 -0400
Date:   Fri, 19 May 2023 15:32:30 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] video: udlfb: Fix endpoint check
Message-ID: <0894f7ac-509f-435f-90ce-b55838ead65c@rowland.harvard.edu>
References: <0000000000004a222005fbf00461@google.com>
 <ZGXVANMhn5j/jObU@ls3530>
 <4cd17511-2b60-4c37-baf3-c477cf6d1761@rowland.harvard.edu>
 <be824fbc-cde4-9a2a-8fb4-1ca23f498dca@gmx.de>
 <2905a85f-4a3b-4a4f-b8fb-a4d037d6c591@rowland.harvard.edu>
 <ZGZ3JPLqxCxA2UB6@ls3530>
 <c7b8e69a-cabe-4e17-a511-66179259d1d7@rowland.harvard.edu>
 <6e93305a-2d70-d411-3e36-c536449295dd@gmx.de>
 <c1cf7ff1-c204-4afc-aa9d-890e07d5ec72@rowland.harvard.edu>
 <eff05b97-6cf0-7688-15cb-08b5b4d9276f@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eff05b97-6cf0-7688-15cb-08b5b4d9276f@gmx.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The syzbot fuzzer detected a problem in the udlfb driver, caused by an
endpoint not having the expected type:


usb 1-1: Read EDID byte 0 failed: -71
usb 1-1: Unable to get valid EDID from device/display
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 9 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880
drivers/usb/core/urb.c:504
Modules linked in:
CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted
6.4.0-rc1-syzkaller-00016-ga4422ff22142 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
04/28/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
...
Call Trace:
 <TASK>
 dlfb_submit_urb+0x92/0x180 drivers/video/fbdev/udlfb.c:1980
 dlfb_set_video_mode+0x21f0/0x2950 drivers/video/fbdev/udlfb.c:315
 dlfb_ops_set_par+0x2a7/0x8d0 drivers/video/fbdev/udlfb.c:1111
 dlfb_usb_probe+0x149a/0x2710 drivers/video/fbdev/udlfb.c:1743


The current approach for this issue failed to catch the problem
because it only checks for the existence of a bulk-OUT endpoint; it
doesn't check whether this endpoint is the one that the driver will
actually use.

We can fix the problem by instead checking that the endpoint used by
the driver does exist and is bulk-OUT.

Reported-and-tested-by: syzbot+0e22d63dcebb802b9bc8@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Pavel Skripkin <paskripkin@gmail.com>
Fixes: aaf7dbe07385 ("video: fbdev: udlfb: properly check endpoint type")
CC: <stable@vger.kernel.org>

---

 drivers/video/fbdev/udlfb.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: usb-devel/drivers/video/fbdev/udlfb.c
===================================================================
--- usb-devel.orig/drivers/video/fbdev/udlfb.c
+++ usb-devel/drivers/video/fbdev/udlfb.c
@@ -27,6 +27,8 @@
 #include <video/udlfb.h>
 #include "edid.h"
 
+#define OUT_EP_NUM	1	/* The endpoint number we will use */
+
 static const struct fb_fix_screeninfo dlfb_fix = {
 	.id =           "udlfb",
 	.type =         FB_TYPE_PACKED_PIXELS,
@@ -1652,7 +1654,7 @@ static int dlfb_usb_probe(struct usb_int
 	struct fb_info *info;
 	int retval;
 	struct usb_device *usbdev = interface_to_usbdev(intf);
-	struct usb_endpoint_descriptor *out;
+	static u8 out_ep[] = {OUT_EP_NUM + USB_DIR_OUT, 0};
 
 	/* usb initialization */
 	dlfb = kzalloc(sizeof(*dlfb), GFP_KERNEL);
@@ -1666,9 +1668,9 @@ static int dlfb_usb_probe(struct usb_int
 	dlfb->udev = usb_get_dev(usbdev);
 	usb_set_intfdata(intf, dlfb);
 
-	retval = usb_find_common_endpoints(intf->cur_altsetting, NULL, &out, NULL, NULL);
-	if (retval) {
-		dev_err(&intf->dev, "Device should have at lease 1 bulk endpoint!\n");
+	if (!usb_check_bulk_endpoints(intf, out_ep)) {
+		dev_err(&intf->dev, "Invalid DisplayLink device!\n");
+		retval = -EINVAL;
 		goto error;
 	}
 
@@ -1927,7 +1929,8 @@ retry:
 		}
 
 		/* urb->transfer_buffer_length set to actual before submit */
-		usb_fill_bulk_urb(urb, dlfb->udev, usb_sndbulkpipe(dlfb->udev, 1),
+		usb_fill_bulk_urb(urb, dlfb->udev,
+			usb_sndbulkpipe(dlfb->udev, OUT_EP_NUM),
 			buf, size, dlfb_urb_completion, unode);
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
