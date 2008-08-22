From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: Re: multiple outputs
Date: Fri, 22 Aug 2008 20:11:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD45C746@dbde02.ent.ti.com>
References: <a728f9f90808220735h498e0b37wd7f9f5d84e346041@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KWXpo-0007po-Ko for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Aug 2008 07:41:52 -0700
Received: from comal.ext.ti.com ([198.47.26.152])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KWXpn-0000Pb-9R
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Aug 2008 07:41:52 -0700
In-Reply-To: <a728f9f90808220735h498e0b37wd7f9f5d84e346041@mail.gmail.com>
Content-Language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alex Deucher <alexdeucher@gmail.com>, Jon Dufresne <jon.dufresne@gmail.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Alex,

We also have a similar requirement for out board; can you please share your top level idea about implementation?

Thanks,
Vaibhav Hiremath
Senior Software Engg.
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927
TI IP Ph: 509-9927
http://dbdwss01.india.ti.com/pspproducts/
-----Original Message-----
From: linux-fbdev-devel-bounces@lists.sourceforge.net [mailto:linux-fbdev-devel-bounces@lists.sourceforge.net] On Behalf Of Alex Deucher
Sent: Friday, August 22, 2008 8:05 PM
To: Jon Dufresne
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] multiple outputs

On Fri, Aug 22, 2008 at 12:42 AM, Jon Dufresne <jon.dufresne@gmail.com> wrote:
> I have a graphics device (intel 945GM) that has multiple outputs (4 in
> this case, although not all can be on at the same time). I want to use
> the graphics device directly through the fb, and not through some
> other layer such as X. When using the fb is it possible to tell the
> graphics device to change outputs through ioctls, or ideally through
> fbset?

The current intelfb driver does not support anything other than the
DAC at the moment anyway.  Work is in progress to support modesetting
in the drm which will allow you to select outputs and crtcs.

Alex

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
