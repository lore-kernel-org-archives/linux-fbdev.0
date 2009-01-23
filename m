From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RFC 2.6.28 1/1] defio: convert pagelist
	into pagemap
Date: Fri, 23 Jan 2009 13:40:39 +0900
Message-ID: <aec7e5c30901222040y5007c614ya2c6baeb48f601d9@mail.gmail.com>
References: <12321948953089-git-send-email-jayakumar.lkml@gmail.com>
	<aec7e5c30901181922o65e7eb4avc57a5e93ad517ddf@mail.gmail.com>
	<45a44e480901190658o78353f53x264bca09003b4b21@mail.gmail.com>
	<aec7e5c30901192138m1ec51767m44dc39d61ae270ce@mail.gmail.com>
	<a5d587fb0901210545l679c106lebadd7b7134a8ead@mail.gmail.com>
	<aec7e5c30901210618q1dd418b3xe580551cdf5e29e5@mail.gmail.com>
	<a5d587fb0901210636s11f629ccl7ba5312e746b0ba1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LQDqZ-0006uq-2l
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 04:40:47 +0000
Received: from fk-out-0910.google.com ([209.85.128.186])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LQDqT-0007Kq-Bz for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 04:40:47 +0000
Received: by fk-out-0910.google.com with SMTP id 19so1063964fkr.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Jan 2009 20:40:39 -0800 (PST)
In-Reply-To: <a5d587fb0901210636s11f629ccl7ba5312e746b0ba1@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Michal Suchanek <hramrach@centrum.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Wed, Jan 21, 2009 at 11:36 PM, Michal Suchanek <hramrach@centrum.cz> wrote:
> 2009/1/21 Magnus Damm <magnus.damm@gmail.com>:
>> On Wed, Jan 21, 2009 at 10:45 PM, Michal Suchanek <hramrach@centrum.cz> wrote:
>>> Yes, it does.
>>>
>>> Suppose I write an application that plots a pixel on the framebuffer,
>>> and tells the kernel that this particular 1x1 square is dirty.
>>>
>>> Now the kernel expands the 1x1 square to a tile and marks it dirty,
>>> and it also finds out that the FB memory was written and one of its
>>> pages is dirty. So it
>>>
>>> a) expands the page to tiles, resulting in a whole row(s) of tiles dirtied
>>>
>>> b) expands the tile to pages resulting in several consecutive pages
>>> that cross the tile dirtied
>>>
>>> Either way it expands the area that is transferred which is what this
>>> whole thing was trying to prevent, right?
>>
>> Correct. If both the tile bits and page bits are used together it will
>> be suboptimal. But this problem will exist regardless of tile bitmap
>> or not, right? Unless we change the format of the frame buffer pixels
>> which will lead to all sorts of other problems.
>>
>> The deferred io code and the damage API need to work together somehow.
>>
>> I suppose the driver could be in "damage mode" when using the damage
>> API and ignore the page bits?
>
> I suppose this would lead to unexpected problems. If my application
> sets the driver into damage mode and crashes I will likely not get any
> output anymore.

Bad luck. =)

> However, this could be probably solved by a timeout - the driver would
> still collect the page dirty bits even in "damage mode", and if a page
> is dirtied and no damage info comes within specified timeout it would
> transfer the pages.

Timeout is one way, or we could cleanup things then the file
descriptor gets closed.

Cheers,

/ magnus

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
