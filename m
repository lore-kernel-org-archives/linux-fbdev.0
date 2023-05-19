Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F82C7EE23
	for <linux-fbdev@archiver.kernel.org>; Fri, 19 May 2023 21:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjESVQd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 19 May 2023 17:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjESVQc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 19 May 2023 17:16:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708B790
        for <linux-fbdev@vger.kernel.org>; Fri, 19 May 2023 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684530986; i=deller@gmx.de;
        bh=BMEKab9yz0yeM4E0mNkWw+xqUCHMJoNRwkVvL7pxYGw=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=adcoW9+xkJTwpckuSEKkxQN1M71fxIMMY72DelJO7x311utuR8JNo0KIeWamxHtLw
         92T12IvFdWFjNzIabq37Sl0CMf/qiTChccehxVK5MNOLkQvpywuxepAVfEnUA0DclJ
         0DUfwu0Ocxk0W5OpWMmL/hVe3tTyo3TX2eJIGmBmO3Kf8Y349tUMgqAn66aHd3c1G3
         l28Pd+h3v5OAfLQuoGEJnWTkl47KWfMReORGWxb11Tvk+61pu6Wlu/JHSBK7U+yqDZ
         2n5Reo2IxIZCFf9wtk86x+/I6lrfSkUsKK5xu8uhnQEOBJMGRrD2NpobR+sf3uLWf7
         kfW+XmVmkny2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530.fritz.box ([94.134.152.232]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1pc6QP2wq7-00Wm7w; Fri, 19
 May 2023 23:16:26 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        stern@rowland.harvard.edu
Subject: [PATCH] fbdev: udlfb: Use usb_control_msg_send()
Date:   Fri, 19 May 2023 23:16:25 +0200
Message-Id: <20230519211625.1072966-1-deller@gmx.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tAhqK71osU+i6Vty4ISHc52tD1C1pbNk0zfiwwYZlIAEeJZeIoG
 hj9/QBxCeop0yag3/ZV1sKwr87iFknPEbqs8gkSftfYJsJnQoDzetQzYrxibPBICUnLo3xr
 6Q78jhUFh/VjynbauhIH0a4S9Gh5Iq1VoVxCSOE7eNv21qrccQxVSkZU7WmfU7K/y3bhIhu
 vTDaL1aZP87BfMCIdkiFQ==
UI-OutboundReport: notjunk:1;M01:P0:7BEwqcsgxo0=;nAeDDHyrZncEvBYIDGh/ShBEhy6
 bHds20clZIWnC2l32NsFDn6x4RpY/7n2DOUx0mHkpWry/PK1hNQ1N09hfldHG2lSBAxSJGc3A
 CorH5PInOou+jAeNcFvI6J4g9kpJI3u8dc7LLngsseUov8g6SemDYl6Ottmoe9EHywSXd0Ws3
 0ZuzNrwPAwwv8yCRVlhfIrq8L2RykWn77TCinrehj1YHY2kqVl0Yv8twbwZR8qeF7yI6QriJc
 xe0dlnZdY3rqSfA7fRqZpwqILWFryqrIggedEYWc9yFT23iFl0ZLWTqMo9rHcAoFy0/TgXffJ
 S033mxrlMb1WI/ouzb0v5i94byogi/17tkeDhAFNPaE7Xyl3G1mpWWIfRoBLQSm2Z3CEOQyZD
 BszKPguelBpD79aEopGhCjqwhXV7ceYgmw31DWpwh1zQvyWw8G1Azlzw39S+ynYzEqO51PAE2
 4QUndH6989tGMPXFIUPpyJQDng+ZSvlLnSYl/6svjd33XRSYZlYPhJOg7pAdxfwCtQotvolV2
 vbHIrs/58ZVeL6M8VeE+XIa18PObKs8KNOuFOF61mjziqxf6NFnKg06cfhyVCHYDCroFJ0vvz
 XQ//Ofu3H4IGASND4IA5hEjeYLtTmq9HP0JQwk90SgC05ZD14wBbPNIhll+2Rtv+YpSmHQMO4
 TSNEUP+0rZ66Vm7rx39cKy0tQe3wrYfcuf/vucMJentinTb5a+TMV44F4j1+pO8Ja5SBrtRZq
 z25iaXg0JSIrBfk/6EUMgjLVvOsOqZOqN/gqAGOFIQCNBTlEWtMWFhWv/jvawG5eHPkIHNCPx
 +8vcYPQzd0JTjEGcCqr9IENUcruFxQj8JnrkS4igzCW68qxi/2QER9tk03ItK0JFz7RPjEAlu
 uIuiAT26vVIgbB7uS8OkRypbQIKclbDcV7g1IiIrLF3Xku2zfa4+KwwE1yvfgN5VwKw6f6Z0b
 2HmGHw==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Use the newly introduced usb_control_msg_send() instead of usb_control_msg=
()
when selecting the channel.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 drivers/video/fbdev/udlfb.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 256d9b61f4ea..dabc30a09f96 100644
=2D-- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1543,24 +1543,16 @@ static const struct device_attribute fb_device_att=
rs[] =3D {
 static int dlfb_select_std_channel(struct dlfb_data *dlfb)
 {
 	int ret;
-	void *buf;
 	static const u8 set_def_chn[] =3D {
 				0x57, 0xCD, 0xDC, 0xA7,
 				0x1C, 0x88, 0x5E, 0x15,
 				0x60, 0xFE, 0xC6, 0x97,
 				0x16, 0x3D, 0x47, 0xF2  };

-	buf =3D kmemdup(set_def_chn, sizeof(set_def_chn), GFP_KERNEL);
-
-	if (!buf)
-		return -ENOMEM;
-
-	ret =3D usb_control_msg(dlfb->udev, usb_sndctrlpipe(dlfb->udev, 0),
-			NR_USB_REQUEST_CHANNEL,
+	ret =3D usb_control_msg_send(dlfb->udev, 0, NR_USB_REQUEST_CHANNEL,
 			(USB_DIR_OUT | USB_TYPE_VENDOR), 0, 0,
-			buf, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
-
-	kfree(buf);
+			&set_def_chn, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT,
+			GFP_KERNEL);

 	return ret;
 }
=2D-
2.40.0

