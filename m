From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: Fw: atyfb doesn't work for me
Date: Wed, 5 Apr 2006 18:53:47 +1000
Message-ID: <21d7e9970604050153p1624614fg5a2fef5086038a61@mail.gmail.com>
References: <20060404030318.3c80b12a.akpm@osdl.org>
	 <20060404151655.GA28811@sci.fi> <87d5fxb7zp.fsf@stark.xeocode.com>
	 <20060404172210.GA7425@sci.fi> <877j65awgp.fsf@stark.xeocode.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FR3lu-0008E3-0V
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 Apr 2006 01:53:50 -0700
Received: from wproxy.gmail.com ([64.233.184.235])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FR3lt-0005cl-08
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 Apr 2006 01:53:50 -0700
Received: by wproxy.gmail.com with SMTP id 50so1513130wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Apr 2006 01:53:47 -0700 (PDT)
In-Reply-To: <877j65awgp.fsf@stark.xeocode.com>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Greg Stark <gsstark@mit.edu>

> Ville Syrj=E4l=E4 <syrjala@sci.fi> writes:
>
> > IIRC SciTech had some solution to the problem... and google found it :)
> > http://www.scitechsoft.com/ftp/snap/linux/videoboot/
>
> Fascinating. it seems the code is all GPL and MIT-style licensed. Any rea=
son
> it hasn't been merged in except for code complexity arguments?

I don't think anyone wants a BIOS emulator in the kernel, it really
should be in userspace or initramfs..

Dave.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
