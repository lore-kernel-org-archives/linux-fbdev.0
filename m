From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: Linux frame buffer query
Date: Wed, 11 Jul 2007 23:25:33 -0700
Message-ID: <45a44e480707112325l5a6d2442vb93dbcd0cca3c8df@mail.gmail.com>
References: <72697.46490.qm@web94112.mail.in2.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8s7L-0004Sf-5o for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jul 2007 23:25:35 -0700
Received: from nz-out-0506.google.com ([64.233.162.234])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8s7K-0007is-Rr
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jul 2007 23:25:35 -0700
Received: by nz-out-0506.google.com with SMTP id f1so107934nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 11 Jul 2007 23:25:34 -0700 (PDT)
In-Reply-To: <72697.46490.qm@web94112.mail.in2.yahoo.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

On 7/11/07, sanjeev sinha <sinha_crl@yahoo.co.in> wrote:
> Hi,
> I am a developer working on linux . previously I was involved in application
> development on linux which do not have any GUI. Rightnow I am working on a
> project wherein I have to grab the linux screen and send it to the network
> at some other locations (where the screen data may be displayed again). I
> analyzed, the best way is to grab the frame buffer and send it through the
> network. I have very little idea about frame buffer and its usage. Can you
> help me out to find the illaborated solution.

If you're running Xorg to drive the framebuffer, then you might want
to look into the vnc module. If you're driving the framebuffer
directly via fbdev then I think you'd need to implement your own
equivalent of the vnc module. I think there's a libvnc library you
could use to help with that.

Hope that helps,
jayakumar

>
> sinha
>
>  ________________________________
>  5, 50, 500, 5000. Store N number of mails in your inbox. Click here.
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
>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
