From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: RV5|6 support
Date: Sat, 27 Sep 2008 10:45:47 -0400
Message-ID: <a728f9f90809270745v5c93a93bmf96dd4feaa40adf1@mail.gmail.com>
References: <20080927113021.GA4211@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alexdeucher@gmail.com>) id 1Kjb3T-0002Cf-Fw
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 27 Sep 2008 14:45:55 +0000
Received: from nf-out-0910.google.com ([64.233.182.190])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kjb3O-0004tH-NC for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 27 Sep 2008 14:45:55 +0000
Received: by nf-out-0910.google.com with SMTP id g16so602208nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 27 Sep 2008 07:45:47 -0700 (PDT)
In-Reply-To: <20080927113021.GA4211@aragorn.home.lxtec.de>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, Sep 27, 2008 at 7:30 AM, Elimar Riesebieter <riesebie@lxtec.de> wrote:
> Hi all,
>
> is there support for ATI RV5* RV6* (RV670) chips with radeonfb?
> Where can I find a patch to support RV670?

There is not.  If you need kernel fb support for newer asics, your
best bet is the new drm modesetting stuff.  It provides fb interfaces.
http://airlied.livejournal.com/62269.html
http://cgit.freedesktop.org/mesa/drm/log/?h=modesetting-gem

Alex

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
