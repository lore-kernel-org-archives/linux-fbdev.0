From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: Problem with cfb_imageblit
Date: Tue, 28 May 2002 10:29:12 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10205281023030.16297-100000@www.transvirtual.com>
References: <1022214909.540.1.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Ckme-0000Pk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 May 2002 10:29:20 -0700
In-Reply-To: <1022214909.540.1.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


>> Hi,
>>
>> I have an unusual problem with cfb_imageblit.  I'm not too sure if this
>> is unique to my system. I get garbage pixels.  For example the
>> underscore character (_) appears like this magnified:
>
>Didn't look carefully enough, I found the problem.
>
>Tony
>
>--- cfbimgblt.c-orig    Fri May 24 15:51:13 2002
>+++ cfbimgblt.c Fri May 24 15:51:28 2002
>@@ -105,7 +105,7 @@
>                                fb_writel((mask & eorx)^bgx, dst);
>                                dst++;
>                        }
>-                       l =- pad;
>+                       l -= pad;
>                        dst1 += p->fix.line_length;
>                }
>        }

Great job finding that bug :-) I applied it to my BK tree. I plan to push
things to Linus now. 



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
