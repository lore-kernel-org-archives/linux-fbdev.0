From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 11 Aug 2010 23:49:29 +0000
Subject: viafb output device rework - part 1
Message-Id: <1281570580-8253-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi,

the objection of this patch series is to clean the output device 
handling up. The end result should be saner code (not setting devices 
that do not exist) as well as more powerfull control over existing 
devices and easier addition of new devices.
This is the first part doing some structural changes and using those to 
switch which of the 2 display data sources (IGA1 or IGA2) is used.
Things that are still missing and (hopefully) will come in follow up 
series are device enable/disable following the same design and exporting 
this flexability in an easy to use way to userspace.

These patches can also be found at
	git://github.com/schandinat/linux-2.6.git viafb-s2v1

Some tests were performed on CLE266, VX800 and VX855.

Any opinions/suggestions?


Regards,

Florian Tobias Schandinat


Florian Tobias Schandinat (11):
      viafb: reset correct PLL
      viafb: remove lcdtbl.h
      viafb: remove stub
      viafb: unify output path configuration
      viafb: enable second display channel at central place
      viafb: rework output device routing
      viafb: propagate __init and __devinit
      viafb: reduce viafb_set_iga_path usage
      viafb: add new output device management
      viafb: use new device routing
      viafb: merge the remaining output path with enable functions

