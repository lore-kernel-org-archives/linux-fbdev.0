From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: framebuffer for LCD connected to GPIO's
Date: Mon, 14 May 2007 11:40:11 -0400
Message-ID: <45a44e480705140840k595c127eia99be20c6c567721@mail.gmail.com>
References: <BAY139-F2DAB37B3C462BFA5B510EE33E0@phx.gbl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hncek-000771-TK for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 May 2007 08:40:15 -0700
Received: from an-out-0708.google.com ([209.85.132.248])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hncej-0001q1-Hl
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 May 2007 08:40:14 -0700
Received: by an-out-0708.google.com with SMTP id c31so2747247anc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 14 May 2007 08:40:13 -0700 (PDT)
In-Reply-To: <BAY139-F2DAB37B3C462BFA5B510EE33E0@phx.gbl>
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

On 5/14/07, vishnu tadepalli <vishnu_tadepalli@hotmail.com> wrote:
> sir,

No "sir". We're all equals in the FOSS world. :-)

> Iam using an ARM 7 based MCU(HMS30c7202),i have interfcaed an 128*64
> greyscale LCD using GPIOs.I would like your help in knowing how to write the
> LCD driver and how to proceed with the framebuffer driver.anybody please
> help me out,thanks in advance.

I'd encourage you to do the interface to the LCD in userspace if
you're planning to only have 128x64. That'll be easier to debug and
get working. If you really do want to have a /dev/fbx type interface
then you might want to look through drivers/video and also how the arm
gpio drivers work in arch/arm. You're using an ARM7 and I'm guessing
it's MMU-less so deferred IO won't be helpful in this case. LDD3 (
http://lwn.net/Kernel/LDD3/ ) may also be useful.

Hope that helps.

Best regards,
jayakumar

ps: gmail accounts are free and they don't append ads to your emails.

>
>
> T.V.R.Prasad
>
> _________________________________________________________________
> Hey its Office 2007. Click here Now.
> http://track1.quasar.co.in/trackQ/trkBanner.asp?Banner=TestDrive_Hotmail_TagOffLines&Creative=HeyItsOffice2007_TextLinks&Camp=office2007&Publisher=MSN&Advertiser=MS_Office2007&Link=http://www.microsoft.com/india/office/newday/default.mspx?nav=v4xcsubmenux
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
