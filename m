From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: w100 fb driver
Date: Sat, 20 Nov 2004 06:10:08 +0800
Message-ID: <200411200610.08802.adaplas@hotpop.com>
References: <021601c4ce58$1111a730$0f01a8c0@max>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVGxQ-00032e-Ro
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 14:10:20 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CVGxP-0005qh-JE
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 14:10:20 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6EA4311F472D
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Nov 2004 22:10:04 +0000 (UTC)
In-Reply-To: <021601c4ce58$1111a730$0f01a8c0@max>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>

On Saturday 20 November 2004 00:51, Richard Purdie wrote:
> I've been working on creating support for the Sharp SL-C7xx series as part
> of a wider effort to create support for the whole Zaurus range of PDAs
> under linux 2.6. The C7xx's contain the ATI w100 video chip which doesn't
> have mainstream kernel support at present.
>
> Sharp did release a driver against 2.4.18 and I've ported this across to
> the 2.6 series. I've also made some fairly large changes to the driver to
> tidy it up and create support for certain video modes Sharp never enabled.
>
> I'd like to discuss whether it'd be possible to include this driver in a
> future kernel? The driver is available at:
> http://www.rpsys.net/openzaurus/w100-r1.patch .
>
> I'm aware the corgi_backlight file included above is out of place and it
> will be moved into the arch/arm/mach-pxa folder. I'm also aware some fb
> changes made in 2.6.10-rc2 need to be applied to this file. Are there any

Not much, but you may need to insert this before initialization:

if (fb_get_options("w100fb", NULL))
	return -ENODEV;

> other problems with the driver as it stands that would prevent its
> inclusion, or areas in the driver that it would be advisable to
> change/improve?

Should be okay, just wondering why not use the kernel i2c algo's instead of
using your own.

Can't comment on backlight support as I don't know a thing about that.

Preferrably, comments should be enclosed in /* */, rather than //

>
> If the driver would be acceptable, what method of submission is preferred?
> (the sourceforge pages seem inactive)

Submit patch inline to this list and CC me.  Preferrably break the patch
down into several, hopefully standalone patches.  Add a changelog, and a
signed-off line.

Referring you to this link on patch submission:

http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

Tony





-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
