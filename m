From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: geode problem
Date: Fri, 28 Apr 2006 15:04:04 +0800
Message-ID: <4451BE64.90405@gmail.com>
References: <eb77d7060604261806y4faa1107l5464316fa005266e@mail.gmail.com>	 <4450E412.9080801@gmail.com>	 <eb77d7060604271156n1c72fd90l19abd8a8e5da65da@mail.gmail.com>	 <44514E3B.5060601@gmail.com>	 <eb77d7060604271610q62827dfdsf67db58231aeb347@mail.gmail.com>	 <44515B69.8010303@gmail.com>	 <eb77d7060604271724k3dd8c9c4w4ddf22bfc7ee6acd@mail.gmail.com>	 <44516155.6090304@gmail.com>	 <eb77d7060604271734x3a393a24ja42886c05130bc3b@mail.gmail.com> <eb77d7060604271825r6ed1213dx9412810f5c9a01d6@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZN1O-0004IM-4L
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 00:04:10 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZN1O-0008WK-75
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 00:04:10 -0700
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZN1M-0005xI-LW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 00:04:10 -0700
Received: by xproxy.gmail.com with SMTP id t4so1318602wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 00:04:07 -0700 (PDT)
In-Reply-To: <eb77d7060604271825r6ed1213dx9412810f5c9a01d6@mail.gmail.com>
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
To: Jorge Luis Zapata Muga <jorgeluis.zapata@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Jorge Luis Zapata Muga wrote:
> On 4/28/06, Jorge Luis Zapata Muga <jorgeluis.zapata@gmail.com> wrote:
>> On 4/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> > Jorge Luis Zapata Muga wrote:
>> > > On 4/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> > >> Jorge Luis Zapata Muga wrote:
>> > >>> On 4/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> > >>>> Jorge Luis Zapata Muga wrote:
>> > >>>>> On 4/27/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> > >>>>>> Jorge Luis Zapata Muga wrote:
> it is working in some way,
> 1. change to other mode (like the one you sent), the monitor powers
> off, so several console  switches able again the screen
> 2. set the attribute 0x10 register to the value 0x01 (enable the
> graphics mode)
> INB(0x3BA);
> INB(0x3DA);
> OUTB(0x3C0, 0x10);
> OUTB(0x3C0, 0x01);
> and it works correctly. this is an empiric solution and i dont know
> what is the functional error,
> maybe some theory might be helpfull.
> 
> PS. i suppose this register should be filled with the correct value
> while writing the GX registers, maybe the VSA code i have is wrong,
> just a guess ...
> 

Your workaround does sound very logical, practically all drivers that are
VGA-based set bit 1 of index 10 of the attribute register (I just examined
a few of them). I don't think that your hardware is an exception, so I
believe this is the right way to go.

Tony


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
