From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: VESA, EDID & flat panels
Date: Tue, 04 Oct 2005 14:56:22 +0800
Message-ID: <43422796.8060505@gmail.com>
References: <1128380013.8267.125.camel@gaston>	 <8a0c36780510031618m48c55f45u648d867bcf0130d2@mail.gmail.com>	 <1128397436.31063.0.camel@gaston>  <434220D0.3020101@gmail.com> <1128407961.31063.50.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMgjI-00047g-K2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 23:56:48 -0700
Received: from xproxy.gmail.com ([66.249.82.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EMgjI-0001Pi-Dy
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 23:56:48 -0700
Received: by xproxy.gmail.com with SMTP id s7so304039wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 03 Oct 2005 23:56:41 -0700 (PDT)
In-Reply-To: <1128407961.31063.50.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Benjamin Herrenschmidt wrote:
>> It think it's because the (basic) EDID is retrieved with (basic) DDC
>> (address 0x50).  If I'm not mistaken, E-EDID is retrieved with E-DDC
>> (address 0xa0). I don't exactly know the protocol (E-DDDC specs are not
>> freely available), but try probing your i2c busses with:
>>
>> i2cdump 0,1,2,etc 0xa0 
>>
>> and see if you get anything.
> 
> Are you sure we aren't talking about the same address here ? Address
> 0xa0 _is_ 0x50 shifted one bit left ... (The low bit of an i2c address
> is the RW bit). i2cdump takes shifted addresses, thus you can't pass it
> anything above 0x7f, thus passing it 0x50 is what gives you address
> 0xa0 :)
> 

Yeah, I just realized that :-)

Tony


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
