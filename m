From: Richard Smith <smithbone@gmail.com>
Subject: Re: New driver: s3d2xfb
Date: Wed, 28 Sep 2005 07:50:32 -0500
Message-ID: <8a0c3678050928055020971433@mail.gmail.com>
References: <433A746A.1070202@ums.usu.ru> <433A88A0.2080906@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKbOR-0002L4-Ty
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 05:50:39 -0700
Received: from zproxy.gmail.com ([64.233.162.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EKbOR-00041q-Sc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 05:50:40 -0700
Received: by zproxy.gmail.com with SMTP id i11so554673nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Sep 2005 05:50:33 -0700 (PDT)
In-Reply-To: <433A88A0.2080906@gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>

>>       if (!cnt) {
>>               save_s3(info);
>>       }

> You don't need to enclose a single statement with "curly braces".

I'm not trying to start any kind of flameage here but my curiosity was
just tweaked by that statement.

What do you like about single line if's over ones with {} that leads
you to advocate their usage?  You've obviously got loads of experience
with a large amount of code written by other people so I'm interested
in your opinion.

Feel free to take it off list if you think its too OT.

I deal with a lot of beginning programmers that go to the University
of Arkansas.  In many of the texts that I see now on introduction to
coding the emphasis is on rules that deal with consistency.  Not using
{} on every if block regardless of the size violates that rule.

I use linux in embedded systems and when I bring up linux on a new
system I sometimes have to pepper a driver with printks to see what's
not working right.

"one liners" are used in many places throughout the driver code and I
always end up going back and adding the {} so that I can add printks.

So IMHO "one liners" are an something of an annoyance. *grin*

--
Richard A. Smith


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
