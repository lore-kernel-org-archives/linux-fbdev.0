From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: Re: multiple outputs
Date: Fri, 22 Aug 2008 08:02:33 -0700
Message-ID: <376ea3380808220802g7edffbd8g54c28fc2b09abd81@mail.gmail.com>
References: <a728f9f90808220735h498e0b37wd7f9f5d84e346041@mail.gmail.com>
	<19F8576C6E063C45BE387C64729E739403CD45C746@dbde02.ent.ti.com>
	<a728f9f90808220757p766c5a4aw57307ca503366f05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KWY9t-0001Rh-6u for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Aug 2008 08:02:37 -0700
Received: from nf-out-0910.google.com ([64.233.182.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KWY9q-0005B7-Nq
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Aug 2008 08:02:37 -0700
Received: by nf-out-0910.google.com with SMTP id g16so224011nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 22 Aug 2008 08:02:33 -0700 (PDT)
In-Reply-To: <a728f9f90808220757p766c5a4aw57307ca503366f05@mail.gmail.com>
Content-Disposition: inline
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
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

> There is currently support for intel, amd, and nvidia chips.  you can
> view the git tree here:
> http://cgit.freedesktop.org/mesa/drm/log/?h=modesetting-gem
> in addition to providing a linux framebuffer interface, you can use
> the native one for more flexibility.  there are some demos to use the
> native interfaces here:
> http://cgit.freedesktop.org/mesa/drm/tree/tests?h=modesetting-gem
> It's still somewhat in flux as the memory management stuff is being worked out.

Does this new design provide a fb, with the same interface, to
projects such as DirectFB. So that the user space programs will work
without change?

Thanks,
Jon

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
