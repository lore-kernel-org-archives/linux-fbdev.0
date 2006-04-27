From: Woody Suwalski <woodys@xandros.com>
Subject: Re: 2.6.16-rc3 + Xorg 6.9.0  - works for me...
Date: Thu, 27 Apr 2006 08:32:38 -0400
Message-ID: <4450B9E6.8010704@xandros.com>
References: <43F4AF97.8080909@xandros.com> <443E3A4B.8000101@netwinder.org> <443E4435.1060904@xandros.com> <443F8EB1.30803@netwinder.org> <444FBE2A.90106@xandros.com> <20060426200907.GE9738@flint.arm.linux.org.uk> <444FD4C9.1040209@xandros.com> <20060427114817.GA7196@deprecation.cyrius.com> <20060427115353.GA30095@flint.arm.linux.org.uk> <4450B7AB.70904@netwinder.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-arm=debian-arm=m.gmane.org@lists.debian.org>
In-Reply-To: <4450B7AB.70904@netwinder.org>
Resent-Message-ID: <kyJpHD.A.-GE.hJMUEB@murphy>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-arm@lists.debian.org>
List-Help: <mailto:debian-arm-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-arm-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-arm-request@lists.debian.org?subject=unsubscribe>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ralph Siemsen <ralphs@netwinder.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Martin Michlmayr <tbm@cyrius.com>, linux-fbdev-devel@lists.sourceforge.net, debian-arm@lists.debian.org



Ralph Siemsen wrote:
> Russell King wrote:
>
>> And under 2.6, does clearing this burst bit solve your problem?
>
> Yes, I have confirmed this behaviour.  Clearing the burst flag makes 
> the 2010 work for me.  I tried all other sorts of changes, like going 
> back to the "OLD_PLL" code and similar, but none had any effect, 
> except for the burst flag.
>
> RMK, its worth noting that "2.4" in the previous conversation was 
> referring to 2.4.19-rmk7, so that may explain why it was working there.
>
> So is it a 2010 bug?  Seems unlikely...
>
> -R
>
> PS. I am still seeing X crash after a few hours running x11perf, now 
> with both 2.4 and 2.6 framebuffers.  Its easily reproduced, but 
> without any debugging symbols in the X binary, I'm not sure how useful 
> a gdb backtrace would be...
>
My Netwinder gateway (Cyber 2000) running 2.6.11 and old Debian 
4.3.0.dfsg.1-14sarge1 XFree is uptime'd for months...
With CPU usage sometimes very heavy....

Did not try the same on new X7.0.

OTOH, x11perf may be more demanding then plain usage...

Woody
