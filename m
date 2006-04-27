From: "Jorge Luis Zapata Muga" <jorgeluis.zapata@gmail.com>
Subject: Re: geode problem
Date: Thu, 27 Apr 2006 21:00:39 +0200
Message-ID: <eb77d7060604271200s723c7f56u8b83b9452c67ce6d@mail.gmail.com>
References: <eb77d7060604261806y4faa1107l5464316fa005266e@mail.gmail.com>
	 <4450E5BA.9020302@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZBqG-0000gr-0c
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Apr 2006 12:07:56 -0700
Received: from pproxy.gmail.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZBqE-0004aS-LG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Apr 2006 12:07:56 -0700
Received: by pproxy.gmail.com with SMTP id i49so2171505pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Apr 2006 12:07:52 -0700 (PDT)
In-Reply-To: <4450E5BA.9020302@arcom.com>
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

On 4/27/06, David Vrabel <dvrabel@arcom.com> wrote:
> Here's my previous response to Jorge for reference.
>
> I would suspect there's something funny going on with the VGA emulation
> going on the the VSA code in the BIOS.  Perhaps have a look through the
> 2.4 driver and see if there's anything in there that disables the VSA
> code/VGA emulation?
>
indeed, i agree with you. the upper "window" seems to be the vga
memory, if i scroll i can see what is "below" for a second. also
changing the crt registers for vga screen start address the green
pixels dissapear, i get black ones instead.

the problem is that on the 2.4 every place where is supposed to keep
the softvga silent doesnt seem to work.

> David Vrabel
> --
> David Vrabel, Design Engineer
>
> Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
> Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
