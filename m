From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: Re: Status of radeonfb in 2.5?
Date: Fri, 18 Oct 2002 16:54:07 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <aopsa6$62b$1@main.gmane.org>
References: <3DACA222.5030409@netscape.net> <20021016223613.17897@192.168.4.1> <3DADD22F.9030508@netscape.net> <1034808341.1229.282.camel@tibook> <aopfrg$aln$1@main.gmane.org> <1034969321.1126.2251.camel@tibook>
Reply-To: nwourms@netscape.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from main.gmane.org ([80.91.224.249])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182e7V-0007eE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 13:53:21 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 182e6a-0001v2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 22:52:24 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Michel D=E4nzer wrote:

>> >> B) Does anyone have a painless, yet precise way of
>> >> generating modelines for fb.modes if you are using
>> >> XFree-4.2?  I only ask because the XFree modelines are all
>> >> determined by i2c DDC probing, thus there are none in the
>> >> XF86Config file.
>> >=20
>> > If the X driver supports Option "UseFBDev", you should be able to use
>> > fbset with that.
>> >=20
>>=20
>> Huh?  The problem is that fbset will not work because I need to populate
>> fb.modes with proper mode lines.  So at the moment fbset won't work at
>> all.
>=20
> I was thinking of running X with Option "UseFBDev" and getting
> information about the modes with fbset.
>=20

Hmm...  I guess that setting doesn't do what I thought it did.  I'll give i=
t=20
a shot and see if it works.  Thanks!

Cheers,
Nicholas




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
