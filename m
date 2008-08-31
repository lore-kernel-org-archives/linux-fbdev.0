From: "Phil Endecott" <phil_utscv_endecott@chezphil.org>
Subject: Re: [PATCH] intelfb: support 945GME (as used
	in	ASUS Eee 901)
Date: Sun, 31 Aug 2008 15:50:54 +0100
Message-ID: <1220194254502@dmwebmail.dmwebmail.chezphil.org>
References: <20080831092722.c80c73c5.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZoGi-0000WR-Vv for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 Aug 2008 07:51:09 -0700
Received: from japan.chezphil.org ([77.240.5.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KZoGi-00078o-LL
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 Aug 2008 07:51:08 -0700
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.69)
	(envelope-from <phil_utscv_endecott@chezphil.org>)
	id 1KZoGX-0003wA-67 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 Aug 2008 15:50:57 +0100
In-Reply-To: <20080831092722.c80c73c5.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: sylvain.meyer@worldonline.fr, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Krzysztof Helt wrote:
> On Fri, 29 Aug 2008 12:50:45 +0100
> "Phil Endecott" <phil_utscv_endecott@chezphil.org> wrote:
>
>> The following patch adds support for Intel's 945GME graphics chip to
>> the intelfb driver.  I have assumed that the 945GME is identical to the
>> already-supported 945GM apart from its PCI IDs; this is based on a quick
>> look at the X driver for these chips which seems to treat them
>> identically.

[snip]

>> -#define SUPPORTED_CHIPSETS	"830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM"
>> +#define SUPPORTED_CHIPSETS  "830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/945GME/965G/965GM"
>>  
>
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>
> BTW, Is it possible to shorten this list by something like "830/845/852/865/915/945/965 models G, GM and GME" or 
> "830M/8x5G/8x5GM/9x5G/9x5GM/9x5GME" or maybe something else?

Doing so would reduce grep-ability.  I did a lot of "grep -r 945GM ." 
while trying to understand this.


Phil.




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
