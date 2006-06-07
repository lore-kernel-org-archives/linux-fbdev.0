From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: intelfb updates
Date: Wed, 7 Jun 2006 18:55:48 +1000
Message-ID: <21d7e9970606070155u5523432ew52ce4e705178711d@mail.gmail.com>
References: <21d7e9970605270158l1ee8551cw7cc8910378cc43de@mail.gmail.com>
	<509BC7A5-C965-47C5-BB5F-416EC23D508A@cecropia.com>
	<2E36B04D-0D7E-4D25-B2C7-D3EF201FFB1E@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fo7Wk-0000zT-Hq for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 16:33:30 -0700
Received: from nz-out-0102.google.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fo7Wk-0003gp-9C
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 16:33:30 -0700
Received: by nz-out-0102.google.com with SMTP id z3so288666nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 07 Jun 2006 16:33:28 -0700 (PDT)
In-Reply-To: <2E36B04D-0D7E-4D25-B2C7-D3EF201FFB1E@cecropia.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dennis Munsie <dmunsie@cecropia.com>
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

>
> I broke apart the commit that Dave titled "align with changes from my
> X driver" into 4 patches -- one for each routine modified.  If I
> apply all of them except the calc_vclock() patch and also all of the
> other patches that Dave has in git, everything works.  No black display.
>
> So, whatever the new calc_vclock() is doing is causing problems, and
> doesn't seem to be contributing much :)

Wow, can you give me some numbers from the old/new calc_vclock?

what does it return when it works and when it doesn't work?

I'm unsure what could be different on i945, but I'm sure something could be :-)

Dave.

>
> As soon as that is fixed, I would say that 945 support is working
> well (at least better than it had been).
>
> dennis
>
> On May 30, 2006, at 2:05 PM, Dennis Munsie wrote:
>
> > I pulled down the changes in your git tree, and when I apply them,
> > I get a kernel panic:
>
