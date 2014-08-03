From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 03 Aug 2014 12:42:36 +0000
Subject: Question on s3fb DDC support
Message-Id: <20140803144236.0494b47a@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Onderj,

Are you still involved in the s3fb driver? So you still have the
hardware to test it?

I am looking at the DDC / I2C implementation in that driver and I'm not
sure I understand how it works. Specifically I am wondering about bit
DDC_DRIVE_EN. It is set unconditionally in s3fb_ddc_setscl() and
s3fb_ddc_setsda() and never cleared explicitly. If this bit is a
regular bit then I don't understand why it is not just set at driver
initialization time. Or is this bit self-clearing and/or not-sticking?

The reason why I am asking is that I don't think the code in these
functions is completely correct. For the I2C protocol, 1 is the natural
state of both lines and the devices on the bus should only ever pull
the lines low to force a 0 state. They should never force a 1 state, as
this breaks some protocol features (specifically arbitration and clock
stretching.) My interpretation of the current code is that the lines
are forced to both 0 and 1 by the master, which is not correct. But as
I don't know how DDC_DRIVE_EN works, I'm not sure, and if it's indeed
broken [1], I'm also not sure how to fix it.

So if you could clarify how bit DDC_DRIVE_EN works, that would be great.

[1] A broken implementation would work fine in most cases and fail only
seldom and randomly, so it could easily go unnoticed.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
