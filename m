From: Tavis Ormandy <taviso@gmail.com>
Date: Fri, 19 Jul 2019 14:03:43 +0000
Subject: stack buffer overflow in fbdev
Message-Id: <20190719140343.GA12952@thinkstation>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello, during a conversation on twitter we noticed a stack buffer
overflow in fbdev with malicious edid data:

https://github.com/torvalds/linux/blob/22051d9c4a57d3b4a8b5a7407efc80c71c7bfb16/drivers/video/fbdev/core/fbmon.c#L1033

There is enough space to have 52 1-byte length values, which makes svd_n
52, then make the final value length 0x1f (the maximum), which makes
svd_n 83 and overflows the 64 byte stack buffer svd[] with controlled
data.

This requires a malicious monitor / projector / etc, so pretty low impact.

I pulled out the code to make a demo (I removed the checksum, but it
doesnt prevent the bug):

https://gist.github.com/taviso/923776e633cb8fb1ab847cce761a0f10

This was discovered by Nico Waisman of Semmle.

Tavis.

-- 
-------------------------------------
taviso@sdf.lonestar.org | finger me for my pgp key.
-------------------------------------------------------
