From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: Re: intelfb crashes during modprobe
Date: Mon, 18 Aug 2008 08:03:44 -0700
Message-ID: <376ea3380808180803r58c16e4dhbc29549cd79c6785@mail.gmail.com>
References: <376ea3380808140821k4e2ec102n452bcc7bb9cc3676@mail.gmail.com>
	<20080814161416.GG5916@omnius.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KV6Go-0004U6-8o for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 08:03:46 -0700
Received: from nf-out-0910.google.com ([64.233.182.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KV6Gn-0001rm-OP
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 08:03:46 -0700
Received: by nf-out-0910.google.com with SMTP id g16so1091706nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 18 Aug 2008 08:03:44 -0700 (PDT)
In-Reply-To: <20080814161416.GG5916@omnius.localdomain>
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
To: Scott Mcdermott <scott.m.mcdermott@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, Aug 14, 2008 at 9:14 AM, Scott Mcdermott
<scott.m.mcdermott@gmail.com> wrote:
> Jon Dufresne on Thu 14/08 08:21 -0700:
>> My target platform is an x86 with an intel 965G
>> chipset running fedora.
>
> I believe intelfb dev for later chipsets has gone here:
>
> http://www.google.com/search?q=%22kernel%20modesetting%22
>
> supposedly 965G works in that tree, and is enableable
> with FC9 shipped kernel given the command line args
> mentioned

I took a look at that site. Does this modeset command line option
affect the framebuffer, or X?

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
