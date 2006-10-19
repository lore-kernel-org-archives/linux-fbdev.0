From: "Ramya Segar" <ramya.segar@gmail.com>
Subject: Re: Double buffering amba-clcd fb driver
Date: Thu, 19 Oct 2006 10:08:39 +0530
Message-ID: <55a8df6f0610182138x366c88feu8ed44811720af741@mail.gmail.com>
References: <55a8df6f0610180327o2fe790actcfca77c94b067919@mail.gmail.com>
	<Pine.LNX.4.62.0610181421460.29508@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0160124087=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GaPg6-00061I-Px for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 21:38:46 -0700
Received: from nf-out-0910.google.com ([64.233.182.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GaPg3-00069C-Ss
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 21:38:46 -0700
Received: by nf-out-0910.google.com with SMTP id p46so1314653nfa
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 18 Oct 2006 21:38:40 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0610181421460.29508@pademelon.sonytel.be>
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

--===============0160124087==
Content-Type: multipart/alternative; 
	boundary="----=_Part_71656_3087062.1161232719954"

------=_Part_71656_3087062.1161232719954
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you Geert for your quick response.
I ll try this out..
--
Ramya.

On 10/18/06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Wed, 18 Oct 2006, Ramya Segar wrote:
> > I m a realtive newcomer to linux and device drivers in particular.
> > I have doubts regrading how to enable double buffering in the fb driver
> for
> > amba-clcd.
> > I m interested in knowing how to enable double bufefring, where two
> buffers
> > are allocated and swapped during vertical blanking period (this is how i
> > understood it).
> > As I understand it, the dbe extension of XFree86 X server provides
> software
> > double buffering, where each window has two buffers, a front and back..
> > If you can point me to any documentation on this, it would be a great
> help..
>
> If your graphics engine supports virtual screens and panning, one simple
> way is
> this:
>   - Make the virtual vertical resolution (fb_var_screeninfo.yres_virtual)
> 2
>     times the real vertical resolution (fb_var_screeninfo.yres)
>   - Use panning to switch from the top (fb_var_screeninfo.yoffset = 0) to
> the
>     bottom (fb_var_screeninfo.yoffset = fb_var_screeninfo.yres) and vice
> versa
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                                             -- Linus
> Torvalds
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>

------=_Part_71656_3087062.1161232719954
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you Geert for your quick response.<br>I ll try this out..<br>--<br>Ramya.<br><br><div><span class="gmail_quote">On 10/18/06, <b class="gmail_sendername">Geert Uytterhoeven</b> &lt;<a href="mailto:geert@linux-m68k.org">
geert@linux-m68k.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Wed, 18 Oct 2006, Ramya Segar wrote:<br>&gt; I m a realtive newcomer to linux and device drivers in particular.
<br>&gt; I have doubts regrading how to enable double buffering in the fb driver for<br>&gt; amba-clcd.<br>&gt; I m interested in knowing how to enable double bufefring, where two buffers<br>&gt; are allocated and swapped during vertical blanking period (this is how i
<br>&gt; understood it).<br>&gt; As I understand it, the dbe extension of XFree86 X server provides software<br>&gt; double buffering, where each window has two buffers, a front and back..<br>&gt; If you can point me to any documentation on this, it would be a great help..
<br><br>If your graphics engine supports virtual screens and panning, one simple way is<br>this:<br>&nbsp;&nbsp;- Make the virtual vertical resolution (fb_var_screeninfo.yres_virtual) 2<br>&nbsp;&nbsp;&nbsp;&nbsp;times the real vertical resolution (fb_var_screeninfo.yres)
<br>&nbsp;&nbsp;- Use panning to switch from the top (fb_var_screeninfo.yoffset = 0) to the<br>&nbsp;&nbsp;&nbsp;&nbsp;bottom (fb_var_screeninfo.yoffset = fb_var_screeninfo.yres) and vice versa<br><br>Gr{oetje,eeting}s,<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Geert
<br><br>--<br>Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- <a href="mailto:geert@linux-m68k.org">geert@linux-m68k.org</a><br><br>In personal conversations with technical people, I call myself a hacker. But<br>
when I'm talking to journalists I just say &quot;programmer&quot; or something like that.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-- Linus Torvalds<br><br>-------------------------------------------------------------------------
<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a><br>_______________________________________________
<br>Linux-fbdev-devel mailing list<br><a href="mailto:Linux-fbdev-devel@lists.sourceforge.net">Linux-fbdev-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel">https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
</a><br></blockquote></div><br>

------=_Part_71656_3087062.1161232719954--


--===============0160124087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0160124087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0160124087==--
