From: Frank Becker <fbecker@intrinsyc.com>
Subject: Re: backlight/frontlight
Date: Fri, 20 Dec 2002 13:20:43 -0800
Sender: linux-arm-kernel-admin@lists.arm.linux.org.uk
Message-ID: <3E0389AB.1070607@intrinsyc.com>
References: <20021219193645.B25149@flint.arm.linux.org.uk> <Pine.LNX.4.44.0212201813390.6471-100000@phoenix.infradead.org> <20021220193359.GB4550@rikers.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-admin@lists.arm.linux.org.uk>
In-Reply-To: <20021220193359.GB4550@rikers.org>
Errors-To: linux-arm-kernel-admin@lists.arm.linux.org.uk
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Chris Larson <kergoth@handhelds.org>
Cc: James Simmons <jsimmons@infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>, linux-arm-kernel@lists.arm.linux.org.uk, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Chris Larson wrote:
> * James Simmons (jsimmons@infradead.org) wrote:
> 
>>Oh. Could someone list all the approaches people toke to solve this 
>>problem. I like to find a solution that covers as many cases as possible.
> 
> 
> James,
> 
> 	As far as I know, the two that seem worth looking at, at the moment,
> are Russ Dill's implementation, which was posted to the LAK list in this
> thread, and Nicolas' implementation in the -pxa patches.
> There are obviously others out there, but said other implementations are
> individual hacks for certain machine types, and aren't generally useful.

Don't blame Nico for the one in the -pxa patches. That
one is my fault ;)

Mmh, can't find that post. Maybe it's on its way...
Anyway, I googled this:
http://russ.dhs.org:8000/files/tuxpatches/backlight-2.4.16-rmk1-2

Looks nicer than what I've been using. I wouldn't call it
backlight though. Backlight is a device specific term for
illumination, isn't it?

Cheers,
-- 
Frank Becker - Intrinsyc Software, Inc. - http://www.intrinsyc.com/
Need a break? http://criticalmass.sf.net/


-------------------------------------------------------------------
Subscription options: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ/Etiquette:       http://www.arm.linux.org.uk/armlinux/mailinglists.php
