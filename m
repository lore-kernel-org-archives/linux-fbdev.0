From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: Bug#347186: linux-image-2.6.14-2-alpha-generic:
 garbled Matrox framebuffer
Date: Wed, 11 Jan 2006 20:36:16 +0800
Message-ID: <43C4FBC0.2080109@gmail.com>
References: <20060109090849.GB3481@tennyson.dodds.net> <20060109093517.GA23253@localhost.localdomain> <20060109105146.GE3481@tennyson.dodds.net> <20060111102827.GF7691@nancy> <43C4EAD4.2090704@pol.net> <20060111114848.GA6453@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EwfDK-0006F9-6X
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:36:30 -0800
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EwfDJ-0004MZ-18
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:36:30 -0800
Received: by zproxy.gmail.com with SMTP id r28so139366nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Jan 2006 04:36:25 -0800 (PST)
In-Reply-To: <20060111114848.GA6453@localhost.localdomain>
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
Cc: "Antonino A. Daplas" <adaplas@pol.net>, maximilian attems <maks@sternwelten.at>, Steve Langasek <vorlon@debian.org>, 347186@bugs.debian.org, Sven Luther <sven.luther@wanadoo.fr>

Sven Luther wrote:
> On Wed, Jan 11, 2006 at 07:24:04PM +0800, Antonino A. Daplas wrote:
>> maximilian attems wrote:
> 
> Also, note : 
> 
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=311815
>   [powerpc] screen garbage when using matroxfb acceleration
> 
> this is on powerpc64 though, so it may be some 64-bitness issue.

Yes.  Reading that bug report, the problem is specific to matroxfb's
hardware acceleration. Petr Vandrovec is the best person for this
problem.

Tony 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
