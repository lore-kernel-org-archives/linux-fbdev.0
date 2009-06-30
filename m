From: eric miranda <ericitaquera@gmail.com>
Subject: Re: [Bugme-new] [Bug 13566] New: nvidiafb
	doesn't get my oooold monitor working
Date: Tue, 30 Jun 2009 00:11:53 -0300
Message-ID: <6d1ac2120906292011m22b9eb30y5b9927598551041@mail.gmail.com>
References: <bug-13566-10286@http.bugzilla.kernel.org/>
	<20090629160442.0cbd68b8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6407963441356503348=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ericitaquera@gmail.com>) id 1MLTlI-00068K-R0
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jun 2009 03:12:00 +0000
Received: from qw-out-1920.google.com ([74.125.92.150])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLTlI-0006BT-0r for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jun 2009 03:12:00 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1718338qwc.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 29 Jun 2009 20:11:54 -0700 (PDT)
In-Reply-To: <20090629160442.0cbd68b8.akpm@linux-foundation.org>
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
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

--===============6407963441356503348==
Content-Type: multipart/alternative; boundary=0016e6469b6a289aa3046d882b91

--0016e6469b6a289aa3046d882b91
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tnx!

2009/6/29 Andrew Morton <akpm@linux-foundation.org>

>
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
>
> On Thu, 18 Jun 2009 13:04:12 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
>
> > http://bugzilla.kernel.org/show_bug.cgi?id=13566
> >
> >            Summary: nvidiafb doesn't get my oooold monitor working
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 2.6.30
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Video(Other)
> >         AssignedTo: drivers_video-other@kernel-bugs.osdl.org
> >         ReportedBy: ericitaquera@gmail.com
> >         Regression: No
>
> There's more info at the above link
>
> >
> > Nvidiafb doesn't get my ooooooold black & white 7" CRT VGA monitor
> working. I
> > have an GeForce 6200 one:
> >
> > root@slackade:~# lspci  | grep -i vga
> > 01:00.0 VGA compatible controller: nVidia Corporation NV44 [GeForce 6200
> > TurboCache(TM)] (rev a1)
> >
> >
> > This is the dmesg output with this old monitor ( or without any ) plugged
> to
> > the VGA output:
> >
> > root@slackade:~# dmesg | grep nvidia
> > nvidiafb 0000:01:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> > nvidiafb: Device ID: 10de0161
> > nvidiafb: CRTC0 analog not found
> > nvidiafb: CRTC1 analog not found
> > nvidiafb: CRTC 1 is currently programmed for TV
> > nvidiafb: Using TV on CRTC 1
> > nvidiafb: Panel is TMDS
> > nvidiafb: MTRR set to ON
> > nvidiafb: Flat panel dithering disabled
> > nvidiafb: PCI nVidia NV16 framebuffer (64MB @ 0xD0000000)
> > root@slackade:~#
> >
> > After that, even if I switch to a brand new 1080p lcd the screen just
> blinks
> > with weird vertical stripes.
> >
> > If I reboot with a newer monitor plugged to VGA output all works fine:
> >
> > root@slackade:~# dmesg | grep nvidia
> > nvidiafb 0000:01:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> > nvidiafb: Device ID: 10de0161
> > nvidiafb: CRTC0 analog found
> > nvidiafb: CRTC1 analog not found
> > nvidiafb: CRTC 0 appears to have a CRT attached
> > nvidiafb: Using CRT on CRTC 0
> > nvidiafb: MTRR set to ON
> > nvidiafb: PCI nVidia NV16 framebuffer (64MB @ 0xD0000000)
> > root@slackade:~#
> >
> > Tnx in advance!
> >
>
> hm.  drivers/video/nvidia/ isn't exactly a hive of development activity
> but let's switch this over to the mailing list and see if there's any
> help.
>
>

--0016e6469b6a289aa3046d882b91
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Tnx!<br><br><div class=3D"gmail_quote">2009/6/29 Andrew Morton <span dir=3D=
"ltr">&lt;<a href=3D"mailto:akpm@linux-foundation.org">akpm@linux-foundatio=
n.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-l=
eft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left:=
 1ex;">
<br>
(switched to email. =A0Please respond via emailed reply-to-all, not via the=
<br>
bugzilla web interface).<br>
<br>
On Thu, 18 Jun 2009 13:04:12 GMT<br>
<a href=3D"mailto:bugzilla-daemon@bugzilla.kernel.org">bugzilla-daemon@bugz=
illa.kernel.org</a> wrote:<br>
<br>
&gt; <a href=3D"http://bugzilla.kernel.org/show_bug.cgi?id=3D13566" target=
=3D"_blank">http://bugzilla.kernel.org/show_bug.cgi?id=3D13566</a><br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0Summary: nvidiafb doesn&#39;t get my oooold mon=
itor working<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0Product: Drivers<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0Version: 2.5<br>
&gt; =A0 =A0 Kernel Version: 2.6.30<br>
&gt; =A0 =A0 =A0 =A0 =A0 Platform: All<br>
&gt; =A0 =A0 =A0 =A0 OS/Version: Linux<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 Tree: Mainline<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 Status: NEW<br>
&gt; =A0 =A0 =A0 =A0 =A0 Severity: normal<br>
&gt; =A0 =A0 =A0 =A0 =A0 Priority: P1<br>
&gt; =A0 =A0 =A0 =A0 =A0Component: Video(Other)<br>
&gt; =A0 =A0 =A0 =A0 AssignedTo: <a href=3D"mailto:drivers_video-other@kern=
el-bugs.osdl.org">drivers_video-other@kernel-bugs.osdl.org</a><br>
&gt; =A0 =A0 =A0 =A0 ReportedBy: <a href=3D"mailto:ericitaquera@gmail.com">=
ericitaquera@gmail.com</a><br>
&gt; =A0 =A0 =A0 =A0 Regression: No<br>
<br>
There&#39;s more info at the above link<br>
<br>
&gt;<br>
&gt; Nvidiafb doesn&#39;t get my ooooooold black &amp; white 7&quot; CRT VG=
A monitor working. I<br>
&gt; have an GeForce 6200 one:<br>
&gt;<br>
&gt; root@slackade:~# lspci =A0| grep -i vga<br>
&gt; 01:00.0 VGA compatible controller: nVidia Corporation NV44 [GeForce 62=
00<br>
&gt; TurboCache(TM)] (rev a1)<br>
&gt;<br>
&gt;<br>
&gt; This is the dmesg output with this old monitor ( or without any ) plug=
ged to<br>
&gt; the VGA output:<br>
&gt;<br>
&gt; root@slackade:~# dmesg | grep nvidia<br>
&gt; nvidiafb 0000:01:00.0: PCI INT A -&gt; GSI 18 (level, low) -&gt; IRQ 1=
8<br>
&gt; nvidiafb: Device ID: 10de0161<br>
&gt; nvidiafb: CRTC0 analog not found<br>
&gt; nvidiafb: CRTC1 analog not found<br>
&gt; nvidiafb: CRTC 1 is currently programmed for TV<br>
&gt; nvidiafb: Using TV on CRTC 1<br>
&gt; nvidiafb: Panel is TMDS<br>
&gt; nvidiafb: MTRR set to ON<br>
&gt; nvidiafb: Flat panel dithering disabled<br>
&gt; nvidiafb: PCI nVidia NV16 framebuffer (64MB @ 0xD0000000)<br>
&gt; root@slackade:~#<br>
&gt;<br>
&gt; After that, even if I switch to a brand new 1080p lcd the screen just =
blinks<br>
&gt; with weird vertical stripes.<br>
&gt;<br>
&gt; If I reboot with a newer monitor plugged to VGA output all works fine:=
<br>
&gt;<br>
&gt; root@slackade:~# dmesg | grep nvidia<br>
&gt; nvidiafb 0000:01:00.0: PCI INT A -&gt; GSI 18 (level, low) -&gt; IRQ 1=
8<br>
&gt; nvidiafb: Device ID: 10de0161<br>
&gt; nvidiafb: CRTC0 analog found<br>
&gt; nvidiafb: CRTC1 analog not found<br>
&gt; nvidiafb: CRTC 0 appears to have a CRT attached<br>
&gt; nvidiafb: Using CRT on CRTC 0<br>
&gt; nvidiafb: MTRR set to ON<br>
&gt; nvidiafb: PCI nVidia NV16 framebuffer (64MB @ 0xD0000000)<br>
&gt; root@slackade:~#<br>
&gt;<br>
&gt; Tnx in advance!<br>
&gt;<br>
<br>
hm. =A0drivers/video/nvidia/ isn&#39;t exactly a hive of development activi=
ty<br>
but let&#39;s switch this over to the mailing list and see if there&#39;s a=
ny<br>
help.<br>
<br>
</blockquote></div><br>

--0016e6469b6a289aa3046d882b91--


--===============6407963441356503348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============6407963441356503348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============6407963441356503348==--
