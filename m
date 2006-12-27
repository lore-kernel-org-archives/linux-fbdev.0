From: "Chris Stones" <chris.stones@gmail.com>
Subject: Re: Framebuffer newbie looking for
	documentation.
Date: Wed, 27 Dec 2006 14:23:46 +0000
Message-ID: <8d502f960612270623j547340efs78a308cd18e12d1a@mail.gmail.com>
References: <8d502f960612261814l6c219339ifa7a0c1467ef4401@mail.gmail.com>
	<414D467D-3306-4174-A834-2DD58D972508@pobox.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0205138332=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GzZh5-0000tA-Cw for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 06:23:47 -0800
Received: from nz-out-0506.google.com ([64.233.162.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GzZh4-0002Db-Tg
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 06:23:47 -0800
Received: by nz-out-0506.google.com with SMTP id i11so2948340nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 27 Dec 2006 06:23:46 -0800 (PST)
In-Reply-To: <414D467D-3306-4174-A834-2DD58D972508@pobox.com>
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

--===============0205138332==
Content-Type: multipart/alternative; 
	boundary="----=_Part_66969_18548829.1167229426186"

------=_Part_66969_18548829.1167229426186
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm Using the vesafb module, as the target hardware ( to which i do not
currently have access ) has no hardware acceleration.

I know the vesafb driver is capable of smooth graphics, as directfb is able
to run on it, with no hardware accelleration and provide perfectly smooth
animation, No image tearing or flickering.

I have studdied the DirectFB source, and SDL's fbcon source.

They use the FBIOPUT_VSCREENINFO ioctl to first set the vyres to double that
of the visible yres, then pan the display for a double buffer effect.

This ioctl works fine, returning 0, however after testing the screen info
with FBIOGET_VSCREENINFO, the yres and vyres values are unchanged.

Thanks for replying.

On 12/27/06, Torgeir Veimo <torgeir@pobox.com> wrote:
>
>
> On 27 Dec 2006, at 02:14, Chris Stones wrote:
>
>
> I am strugling to find documentation, but from reading linux/fb.h it seems
> the only way to do this is with the FBIOGET_VBLANK ioctl.... however, for
> unknown reasons, this is always returning -1 ( ERROR ! )
>
>
> That means that the framebuffer module used doesn't support that ioctl.
> It's not implemented for all framebuffer modules. The matrox framebuffer has
> it, and I have posted a patch in the past for the radeon framebuffer.
> Which framebuffer module are you using?
>
> --
> Torgeir Veimo
> torgeir@pobox.com
>
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
>
>

------=_Part_66969_18548829.1167229426186
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;m Using the vesafb module, as the target hardware ( to which i do not currently have access ) has no hardware acceleration.<br><br>I know the vesafb driver is capable of smooth graphics, as directfb is able to run on it, with no hardware accelleration and provide perfectly smooth animation, No image tearing or flickering.
<br><br>I have studdied the DirectFB source, and SDL&#39;s fbcon source.<br><br>They use the FBIOPUT_VSCREENINFO ioctl to first set the vyres to double that of the visible yres, then pan the display for a double buffer effect.
<br><br>This ioctl works fine, returning 0, however after testing the screen info with FBIOGET_VSCREENINFO, the yres and vyres values are unchanged.<br><br>Thanks for replying.<br><br><div><span class="gmail_quote">On 12/27/06, 
<b class="gmail_sendername">Torgeir Veimo</b> &lt;<a href="mailto:torgeir@pobox.com">torgeir@pobox.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div style=""><span class="q"><br><div><div>On 27 Dec 2006, at 02:14, Chris Stones wrote:</div><br><blockquote type="cite"><span style="border-collapse: separate; border-spacing: 0px; color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;">
<br>I am strugling to find documentation, but from reading linux/fb.h it seems the only way to do this is with the FBIOGET_VBLANK ioctl.... however, for unknown reasons, this is always returning -1 ( ERROR ! )<span>&nbsp;</span>
<br></span></blockquote></div><div><br></div></span>That means that the framebuffer module used doesn&#39;t support that ioctl. It&#39;s not implemented for all framebuffer modules. The matrox framebuffer has it, and I have posted a patch in the past for the radeon framebuffer.&nbsp;
<div><br></div><div>Which framebuffer module are you using?</div><div><br><div> <span style="border-collapse: separate; border-spacing: 0px; color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;">
<span style="border-collapse: separate; border-spacing: 0px; color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;">
<span style="border-collapse: separate; border-spacing: 0px; color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;">
<div>--&nbsp;</div><div>Torgeir Veimo</div><div><a href="mailto:torgeir@pobox.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">torgeir@pobox.com</a></div><div><br></div><br></span></span></span> </div>
<br></div></div>
<br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br><br>_______________________________________________<br>Linux-fbdev-devel mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Linux-fbdev-devel@lists.sourceforge.net">
Linux-fbdev-devel@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
</a><br><br><br></blockquote></div><br>

------=_Part_66969_18548829.1167229426186--


--===============0205138332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0205138332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0205138332==--
