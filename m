From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: Re: [PATCH 2.6.17-rc4-mm3] intelfb 945G/GM video fix
Date: Sat, 27 May 2006 14:19:18 +1000
Message-ID: <21d7e9970605262119s5accd9c7w6830cc5a3470af07@mail.gmail.com>
References: <06E28340-802B-4587-9A76-75A59127F7F9@cecropia.com>
	 <Pine.LNX.4.64.0605260032200.5525@skynet.skynet.ie>
	 <4477708F.4090505@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FjqGp-0002v9-QJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 May 2006 21:19:23 -0700
Received: from wr-out-0506.google.com ([64.233.184.230])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FjqGn-00067s-Ha
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 May 2006 21:19:23 -0700
Received: by wr-out-0506.google.com with SMTP id i20so238748wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 26 May 2006 21:19:20 -0700 (PDT)
In-Reply-To: <4477708F.4090505@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Dennis Munsie <dmunsie@cecropia.com>, Eric Hustvedt <ehustvedt@cecropia.com>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, Dave Airlie <airlied@linux.ie>

> >> This is a small patch that I would like others to take a look at.  We
> >> ran into an issue where on the motherboard we are using, Intel
> >> D945GTP, the video wouldn't come up in the proper state even with Dave
> >> Airlie's patches for 945. I had created a 945 patch that I hadn't
> >> released, and that one did work.  The only difference between the two
> >> was that I had a one line hack to write to the DPLL register twice.
> >> Now, this should be harmless on other chipsets, but I can't be sure
> >> without testing.  I've tried asking Intel about this, but I haven't
> >> gotten any information on it from them.
> >
> > This just looks wrong, I've got an 945G at home, I'm just a bit swamped
> > with other things, the current intelfbdev code could do with a refresh
> > from my X.org driver tree, I just haven't had the time lately to pull
> > over the code....
> >
> > you can see my X.org driver code at:
> > git pull http://people.freedesktop.org/~airlied/git/xf86-video-i810/.gi=
t
> >
>
> I'll drop this patch in the meantime.  As for the 3 other patches, do the=
y
> look okay to you?

I was going to pull them into my intelfb git tree as they look quite
obvious.. I was going to ask Linus to pull my tree when 2.6.18 opens
up..

Dave.


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
