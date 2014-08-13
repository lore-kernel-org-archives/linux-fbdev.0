From: Luc Verhaegen <libv@skynet.be>
Date: Wed, 13 Aug 2014 07:17:15 +0000
Subject: simplefb: add clock handling
Message-Id: <1407914239-12054-1-git-send-email-libv@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is needed for the sunxi platform, where the u-boot initialized display 
engine gets disabled by the clocks framework if certain clocks are not 
claimed. Once these clocks are disabled, register content is lost, and there
is no turning back unless a full display driver is loaded, which kind of
beats the purpose of having simplefb running.

The lack of clock handling should plague more hardware, but so far rpi is the 
best known user of simplefb, and its stepmotherly handling of the arm core
has kept these sort of issues from the kernel.

The sunxi u-boot side code can be found here:
https://groups.google.com/forum/#!topic/linux-sunxi/dPs958sIXvY

Patch 3 might be controversial, as this does not achieve anything real today,
since the status property in dt is only really evaluated when dealing with a
nodes memory. It still seems like a good idea to at least flag this memory or
node as disabled, as we really have no way back when the clocks get disabled.

Luc Verhaegen.

