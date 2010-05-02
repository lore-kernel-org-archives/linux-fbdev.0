From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 02 May 2010 15:17:30 +0000
Subject: viafb suspend & resume, v2
Message-Id: <1272813454-3229-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, corbet@lwn.net

This is the second version of this patch series. It is forward ported to apply
on Jon's current viafb-posted branch. Furthermore the engine is only
(re)started if the mmio space is mapped.
There are still issues left especially device configuration and it does not yet
integrate nicely in the new structure of the driver. However it is in a state
where it shouldn't hurt anyone but could be useful for some people.


Thanks,

Florian Tobias Schandinat


Deepak Saxena (1):
      Minimal support for viafb suspend/resume

Florian Tobias Schandinat (3):
      viafb: restore display on resume
      viafb: make suspend and resume work (on all machines?)
      viafb: fix hardware acceleration for suspend & resume

