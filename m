From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: x86_64 64bit kernel rivafb broke between 2.6.8.1 and linus bk as of today
Date: Thu, 18 Nov 2004 08:02:09 +0800
Message-ID: <200411180802.09994.adaplas@hotpop.com>
References: <200411162244.37709.andrew@walrond.org> <200411180628.14510.adaplas@hotpop.com> <200411172250.20063.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUZkl-0008Ju-Bz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 16:02:23 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CUZkk-0007wb-KD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 16:02:23 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A72A69F712C
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 18 Nov 2004 00:02:15 +0000 (UTC)
In-Reply-To: <200411172250.20063.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>
Cc: adaplas@pol.net

On Thursday 18 November 2004 06:50, Andrew Walrond wrote:
> On Wednesday 17 Nov 2004 22:28, Antonino A. Daplas wrote:
> > Umm, forget about the first patch, just apply the second patch.
>
> Absolutely no change I'm afraid.
>
> You want me to try reverting the functions you mentioned?
>

Try the patch that reverts the "burst" code, and if that does not work,
then yes, you might have to revert.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
