From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 1/1 2.6.25] fbdev: bugfix for
	multiprocess defio
Date: Tue, 8 Jul 2008 08:50:30 -0400
Message-ID: <45a44e480807080550r65b3c5a2me3dce82629e44ccb@mail.gmail.com>
References: <20080428020140.8662.66707.sendpatchset@hit-nxdomain.opendns.com>
	<20080430133759.e39bf34c.akpm@linux-foundation.org>
	<45a44e480805050023h68cffe15h5e309707ec6d8380@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KGCeP-0004Sq-9I for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 05:50:33 -0700
Received: from nf-out-0910.google.com ([64.233.182.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KGCeO-0003so-O9
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 05:50:33 -0700
Received: by nf-out-0910.google.com with SMTP id g16so692772nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 08 Jul 2008 05:50:31 -0700 (PDT)
In-Reply-To: <45a44e480805050023h68cffe15h5e309707ec6d8380@mail.gmail.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bernard@largestprime.net, linux-fbdev-devel@lists.sourceforge.net, Markus Armbruster <armbru@redhat.com>

On Mon, May 5, 2008 at 3:23 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Wed, Apr 30, 2008 at 1:37 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>>
>> On Sun, 27 Apr 2008 22:01:40 -0400
>>  Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>>
>>  > +     /* we loop through the pagelist before adding in order
>>  > +     to keep the pagelist sorted */
>>  > +     list_for_each_entry(cur, &fbdefio->pagelist, lru) {
>>
>>  Did you consider using !list_empty(&page->lru) to avoid the linear search?
>>
>
> Ah, no, I didn't think of that. I agree that checking list_empty would
> be far better. I'll redo the patch using that.
>
> Thanks,
> jaya
>

Hi Andrew,

I encountered some complexity when trying to use page->lru because its
not empty on its first mkwrite. I think there are probably deeper
issues that repurposing page->lru for use in defio causes. I'm working
on it.

In the meantime, it turns out that suspend/resume of xen pvfb is
affected by the same bug that raised this patch. Markus suggested,
http://marc.info/?l=linux-kernel&m=121368814027583&w=2 , that perhaps
this existing patch could be merged in the interim while a better
solution is worked on.

Would you be okay with adding this patch back into the queue? If so,
should I repost it here?

Thanks,
jaya

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
