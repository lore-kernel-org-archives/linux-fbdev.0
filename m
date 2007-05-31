From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 3/9] cfag12864bfb: Use sys_ instead
	of cfb_ framebuffer	accessors
Date: Thu, 31 May 2007 21:15:17 +0800
Message-ID: <1180617317.4581.0.camel@daplas>
References: <4658D547.8020707@gmail.com>
	<653402b90705310610n2d66717ap890605adeb0a2033@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Htkju-0002fV-CH for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:30:54 -0700
Received: from wx-out-0506.google.com ([66.249.82.234])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Htkjt-0006ZL-2e
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:30:54 -0700
Received: by wx-out-0506.google.com with SMTP id t15so157062wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 31 May 2007 06:30:52 -0700 (PDT)
In-Reply-To: <653402b90705310610n2d66717ap890605adeb0a2033@mail.gmail.com>
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
To: Miguel Ojeda <maxextreme@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Avuton Olrich <avuton@gmail.com>

On Thu, 2007-05-31 at 15:10 +0200, Miguel Ojeda wrote:
> On 5/27/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > From: Avuton Olrich <avuton@gmail.com>
> >

> ACK, I will test it asap.
> 
> Thanks for the fix, I'm a bit outdated, as I'm taking exams this weeks.

That's okay, the sys_* drawing libraries are very new additions.

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
