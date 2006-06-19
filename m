From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: intelfb updates
Date: Tue, 20 Jun 2006 09:14:08 +1000
Message-ID: <21d7e9970606191614n324f3582pedb6488e36722ac1@mail.gmail.com>
References: <21d7e9970605270158l1ee8551cw7cc8910378cc43de@mail.gmail.com>
	<509BC7A5-C965-47C5-BB5F-416EC23D508A@cecropia.com>
	<2E36B04D-0D7E-4D25-B2C7-D3EF201FFB1E@cecropia.com>
	<21d7e9970606070155u5523432ew52ce4e705178711d@mail.gmail.com>
	<52176753-4100-4290-963B-C9D1B73526D0@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FsSwb-0006G3-Vw for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jun 2006 16:14:10 -0700
Received: from nz-out-0102.google.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FsSwb-0005VS-MS
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jun 2006 16:14:09 -0700
Received: by nz-out-0102.google.com with SMTP id z3so1022280nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 19 Jun 2006 16:14:08 -0700 (PDT)
In-Reply-To: <52176753-4100-4290-963B-C9D1B73526D0@cecropia.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, "Antonino A. Daplas" <adaplas@gmail.com>

> dave --
>
> just wanted to follow up on this.  You latest commit in your git tree
> fixed the problem for me.  I now have a working display with just
> your patchset :)

I thought it might, I'm going to put my latest tree into 2.6.18, and
I'll add your i2c stuff to my -mm tree for now...  It might get into
2.6.18 later..

Dave.

>
> dennis
>
> On Jun 7, 2006, at 4:55 AM, Dave Airlie wrote:
>
> > Wow, can you give me some numbers from the old/new calc_vclock?
> >
> > what does it return when it works and when it doesn't work?
> >
> > I'm unsure what could be different on i945, but I'm sure something
> > could be :-)
> >
> > Dave.
>
>
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
