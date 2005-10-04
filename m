From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: VESA, EDID & flat panels
Date: Tue, 04 Oct 2005 16:39:21 +1000
Message-ID: <1128407961.31063.50.camel@gaston>
References: <1128380013.8267.125.camel@gaston>
	 <8a0c36780510031618m48c55f45u648d867bcf0130d2@mail.gmail.com>
	 <1128397436.31063.0.camel@gaston>  <434220D0.3020101@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMgW3-0003ZP-7O
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 23:43:07 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EMgW1-0006CS-6c
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 23:43:07 -0700
In-Reply-To: <434220D0.3020101@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> It think it's because the (basic) EDID is retrieved with (basic) DDC
> (address 0x50).  If I'm not mistaken, E-EDID is retrieved with E-DDC
> (address 0xa0). I don't exactly know the protocol (E-DDDC specs are not
> freely available), but try probing your i2c busses with:
> 
> i2cdump 0,1,2,etc 0xa0 
> 
> and see if you get anything.

Are you sure we aren't talking about the same address here ? Address
0xa0 _is_ 0x50 shifted one bit left ... (The low bit of an i2c address
is the RW bit). i2cdump takes shifted addresses, thus you can't pass it
anything above 0x7f, thus passing it 0x50 is what gives you address
0xa0 :)

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
