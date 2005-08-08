From: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: [Linux-fbdev-devel] CRTC scanout buffer types
Date: Sun, 7 Aug 2005 22:05:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0508072202070.12301@node2.an-vo.com>
References: <9e47339105080513195dee0804@mail.gmail.com> 
 <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be>
 <9e47339105080706414faf1e40@mail.gmail.com> <42F67719.9050805@us.ibm.com>
 <42F68105.1080207@pol.net> <Pine.LNX.4.62.0508071830270.11306@node2.an-vo.com>
 <42F6B21E.1070405@gmail.com>
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
Mime-Version: 1.0
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <42F6B21E.1070405@gmail.com>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Ian Romanick <idr@us.ibm.com>, Jon Smirl <jonsmirl@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, DRI developer's list <dri-devel@lists.sourceforge.net>



On Mon, 8 Aug 2005, Antonino A. Daplas wrote:

> Vladimir Dergachev wrote:
>>> I agree that something like the above is acceptable, exept that we need
>>> an extra field for offset and another if indexed color or not. So 
>>> something like:
>>> 
>>> A:2/0/R:10/2/G:10/12/B:10/22//I
>> 
>> This is getting more cryptic by the minute.
>> 
>> Can't we have a simple field: value lines ? Something like:
>> AlphaBits: 2
>> AlphaOffset: 0
>> 
>
> The problem with doing that is you need to set everything in one go.
> Separating all those fields into different sysfs attributes will have
> a problem with synchronization.
>
> One workaround is to have another attribute 'Activate'. Nothing is set
> until the 'Activate' attribute is written to.  There is still the problem
> of another process changing the other attributes behind the back of the
> original process.

I think "Activate" is a good idea and it kinda mimics what graphics chips 
themselves do, so another reason to like it.

As for simultaneous access - does it actually make sense that two programs
would want to change screen format at the same time ?

Even if access is serialized in some fashion, at most one of the programs 
will get format that it requested, so we lose nothing by allowing it to be 
none.

                         best

                              Vladimir Dergachev

>
> Tony
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
--
