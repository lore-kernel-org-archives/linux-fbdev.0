From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 24 Aug 2011 13:40:46 +0000
Subject: linux-next tree addition request (fbdev)
Message-Id: <4E54FF5E.5050308@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>

Hi Stephen,

can you please add

    git://github.com/schandinat/linux-2.6.git fbdev-next

to linux-next. It collects patches for the frame buffer subsystem.
Can you please add the linux-fbdev@vger.kernel.org mailing list as additional
contact for warnings/errors/problems?

You probably want to drop Paul's fbdev branches as they contain some outdated
patches that will conflict with the newer versions.


Thanks,

Florian Tobias Schandinat
