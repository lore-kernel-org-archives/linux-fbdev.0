From: =?iso-8859-1?q?Marc_Poulhi=E8s?= <marc.poulhies@epfl.ch>
Subject: Re: Fw: [Bugme-new] [Bug 4217] New: radeonfb makes system hang and
 LCD "burn"
Date: Tue, 15 Feb 2005 22:42:32 +0100
Message-ID: <87fyzxsdo7.fsf@kataplop.net>
References: <20050215121555.54c63ed2.akpm@osdl.org>
	<1108502142.13394.2.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1ASg-0008QC-9u
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 13:42:26 -0800
Received: from postfix4-1.free.fr ([213.228.0.62])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1ASd-000693-Pn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 13:42:26 -0800
In-Reply-To: <1108502142.13394.2.camel@gaston> (Benjamin Herrenschmidt's
 message of "Wed, 16 Feb 2005 08:15:42 +1100")
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2005-02-15 at 12:15 -0800, Andrew Morton wrote:
>> 
>> Begin forwarded message:
>> 
>> Date: Tue, 15 Feb 2005 12:03:52 -0800
>> From: bugme-daemon@osdl.org
>> To: bugme-new@lists.osdl.org
>> Subject: [Bugme-new] [Bug 4217] New: radeonfb makes system hang and LCD "burn"
>
> What if you load the module with option "default_dynclk=-1" ?
>
> (Or if radeonfb is built-in, do radeonfb.default_dynclk=-1 on the kernel
> command line). 

Seems to work a bit more. Module loads correctly, system is still
responding, but display is not correct. System caret seems to be the
only thing displayed, and it moves when I type, but no characters get
displayed.

Do you need some more informations? (like debug output) 

Thanks,
Marc


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
