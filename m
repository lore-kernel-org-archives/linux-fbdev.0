From: Egbert Eich <eich@pdx.freedesktop.org>
Subject: Re: Current discussion about the future of free software graphics
Date: Wed, 12 May 2004 15:54:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <16546.11443.44701.174054@xf11.fra.suse.de>
References: <200405111309.AA504430924@sottekland.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: sottek@sottekland.com wrote on Tuesday, 11 May 2004 at 13:09:48 -0500 
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: sottek@sottekland.com
Cc: eich@pdx.freedesktop.org, agd5f@yahoo.com, michel@daenzer.net, keithp@keithp.com, jonsmirl@yahoo.com, jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net

sottek writes:
 > Can we wrap this up the discussion and try to get to a consensus on
 > design requirements? I think most of the opinions are starting to
 > solidify enough to start hashing out the requirements and actual
 > design.
 > 
 > Also, we probably want to drop the communication down to just one
 > list? I think dri-devel seems to have the widest group of subscribers.

Well, I would think there are a lot more people who are interested
in this subject than are subscribed on dri-devel. dri-devel really
has a different scope.

 > 4: Design must insure that user applications may not set the hardware
 > into an unstable state that could lead to lockup or damage display
 > devices.

The 'driver' must do mode validation using data supplied by either the 
display itself or the application (you need the second as some display 
devices may  not support sending this data or the data sent is bogus).

Broken video modes usually result from:
1. broken drivers
2. bogus user level configuration/override


Egbert.


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
