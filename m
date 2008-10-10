From: "Diego Ocampo" <diegoocampo8@gmail.com>
Subject: Re: [Bugme-new] [Bug 11734] New: Ramdonly linux
	don't boot,
	it hangs at the very first stage of booting with some error related
	with uvesafb
Date: Fri, 10 Oct 2008 23:07:39 +0200
Message-ID: <7bdb0b620810101407y3a461c1ev6257b60259ed13a0@mail.gmail.com>
References: <bug-11734-10286@http.bugzilla.kernel.org/>
	<20081010135045.8b4772f5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5836853229030529537=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <diegoocampo8@gmail.com>) id 1KoPD9-0004fB-93
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Oct 2008 21:07:47 +0000
Received: from yw-out-1718.google.com ([74.125.46.157])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KoPD3-0007fS-Fi for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Oct 2008 21:07:47 +0000
Received: by yw-out-1718.google.com with SMTP id 6so231798ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 10 Oct 2008 14:07:40 -0700 (PDT)
In-Reply-To: <20081010135045.8b4772f5.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Januszewski <spock@gentoo.org>, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

--===============5836853229030529537==
Content-Type: multipart/alternative; 
	boundary="----=_Part_123357_24410124.1223672859543"

------=_Part_123357_24410124.1223672859543
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

You mean the firmware of the graphic card? In any case windows vista boots
always without any problem... and also ubuntu hardy (kernel 2.6.24) boot
always without problems

On Fri, Oct 10, 2008 at 10:50 PM, Andrew Morton
<akpm@linux-foundation.org>wrote:

>
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
>
> On Fri, 10 Oct 2008 13:37:41 -0700 (PDT)
> bugme-daemon@bugzilla.kernel.org wrote:
>
> > http://bugzilla.kernel.org/show_bug.cgi?id=11734
> >
> >            Summary: Ramdonly linux don't boot, it hangs at the very first
> >                     stage of booting with some error related with uvesafb
> >            Product: Drivers
> >            Version: 2.5
> >      KernelVersion: 2.6.27-6
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Video(Other)
> >         AssignedTo: drivers_video-other@kernel-bugs.osdl.org
> >         ReportedBy: diegoocampo8@gmail.com
> >
> >
> > Latest working kernel version: 2.6.24-xx
> > Earliest failing kernel version: ----
> > Distribution: Ubuntu Intrepid Ibex
> > Hardware Environment: Samsung R70 / A009
> > Software Environment: Ubuntu Intrepid Ibex Beta.
> > Problem Description: First of all: I am not a linux expert so please
> don't ask
> > me too much technical questions about the problem, but i will try to help
> as
> > much as i can...
> > I am not sure if it is related with Ubuntu or with the kernel but the
> problems
> > take place in the very first stage of booting (maybe with the loading of
> the
> > kernel??) and I get the following error messages:
> > "606627 uvesafb: failed to execute /sbin/v86d"
> > "606719 uvesafb: make sure that the v86d helper is installed and
> executable"
> > "606814 uvesafb: Getting VBE info block failed (eax=0x4f00, err=-2)"
> > "606905 uvesafb: vbe_init() failed with -22
> >
> > Then the loading goes on a little bit until reaching the message:
> > "Loading hardware drivers ....... " and the laptop freezers at this
> point.
> >
> > Like i said this is a ramdonly problem,if i restart the computer most
> probably
> > ubuntu starts, but i think it is very annoying anyway!.
> >
>
> hm.  firmware loader problems, perhaps?
>

------=_Part_123357_24410124.1223672859543
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">You mean the firmware of the graphic card? In any case windows vista boots always without any problem... and also ubuntu hardy (kernel 2.6.24) boot always without problems<br><br><div class="gmail_quote">On Fri, Oct 10, 2008 at 10:50 PM, Andrew Morton <span dir="ltr">&lt;<a href="mailto:akpm@linux-foundation.org">akpm@linux-foundation.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
(switched to email. &nbsp;Please respond via emailed reply-to-all, not via the<br>
bugzilla web interface).<br>
<br>
On Fri, 10 Oct 2008 13:37:41 -0700 (PDT)<br>
<a href="mailto:bugme-daemon@bugzilla.kernel.org">bugme-daemon@bugzilla.kernel.org</a> wrote:<br>
<br>
&gt; <a href="http://bugzilla.kernel.org/show_bug.cgi?id=11734" target="_blank">http://bugzilla.kernel.org/show_bug.cgi?id=11734</a><br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Summary: Ramdonly linux don&#39;t boot, it hangs at the very first<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; stage of booting with some error related with uvesafb<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Product: Drivers<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Version: 2.5<br>
&gt; &nbsp; &nbsp; &nbsp;KernelVersion: 2.6.27-6<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Platform: All<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; OS/Version: Linux<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Tree: Mainline<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Status: NEW<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Severity: normal<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Priority: P1<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Component: Video(Other)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; AssignedTo: <a href="mailto:drivers_video-other@kernel-bugs.osdl.org">drivers_video-other@kernel-bugs.osdl.org</a><br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; ReportedBy: <a href="mailto:diegoocampo8@gmail.com">diegoocampo8@gmail.com</a><br>
&gt;<br>
&gt;<br>
&gt; Latest working kernel version: 2.6.24-xx<br>
&gt; Earliest failing kernel version: ----<br>
&gt; Distribution: Ubuntu Intrepid Ibex<br>
&gt; Hardware Environment: Samsung R70 / A009<br>
&gt; Software Environment: Ubuntu Intrepid Ibex Beta.<br>
&gt; Problem Description: First of all: I am not a linux expert so please don&#39;t ask<br>
&gt; me too much technical questions about the problem, but i will try to help as<br>
&gt; much as i can...<br>
&gt; I am not sure if it is related with Ubuntu or with the kernel but the problems<br>
&gt; take place in the very first stage of booting (maybe with the loading of the<br>
&gt; kernel??) and I get the following error messages:<br>
&gt; &quot;606627 uvesafb: failed to execute /sbin/v86d&quot;<br>
&gt; &quot;606719 uvesafb: make sure that the v86d helper is installed and executable&quot;<br>
&gt; &quot;606814 uvesafb: Getting VBE info block failed (eax=0x4f00, err=-2)&quot;<br>
&gt; &quot;606905 uvesafb: vbe_init() failed with -22<br>
&gt;<br>
&gt; Then the loading goes on a little bit until reaching the message:<br>
&gt; &quot;Loading hardware drivers ....... &quot; and the laptop freezers at this point.<br>
&gt;<br>
&gt; Like i said this is a ramdonly problem,if i restart the computer most probably<br>
&gt; ubuntu starts, but i think it is very annoying anyway!.<br>
&gt;<br>
<br>
hm. &nbsp;firmware loader problems, perhaps?<br>
</blockquote></div><br></div>

------=_Part_123357_24410124.1223672859543--


--===============5836853229030529537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============5836853229030529537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============5836853229030529537==--
