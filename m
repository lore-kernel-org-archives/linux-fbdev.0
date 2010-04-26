From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 26 Apr 2010 18:09:43 +0000
Subject: viafb suspend & resume
Message-Id: <1272305387-4872-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, corbet@lwn.net

This little patch series tries to implement suspend and resume in a sane way
that should work on all IGPs supported. It's not yet error free but should be
a good start. It is based on the second version of Jon's first patch series.


Thanks,

Florian Tobias Schandinat


Deepak Saxena (1):
      Minimal support for viafb suspend/resume

Florian Tobias Schandinat (3):
      viafb: restore display on resume
      viafb: make suspend and resume work (on all machines?)
      viafb: fix hardware acceleration for suspend & resume

