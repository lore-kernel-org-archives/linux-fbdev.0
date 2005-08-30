From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
Date: Tue, 30 Aug 2005 19:58:51 +0200
Message-ID: <43149E5B.7040006@t-online.de>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAAKq-0004mW-SN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Aug 2005 10:55:48 -0700
Received: from mailout10.sul.t-online.com ([194.25.134.21])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAAKp-0006PD-OD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Aug 2005 10:55:49 -0700
In-Reply-To: <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Jochen Hein <jochen@jochen.org>


>Probably you can make it even faster by avoiding the multiplication, lik=
e
>
>    unsigned int offset =3D 0;
>    for (i =3D 0; i < image.height; i++) {
>	dst[offset] =3D src[i];
>	offset +=3D pitch;
>    }
>

More than two decades ago I learned to avoid mul and imul. Use shifts,=20
add and lea instead,
that was the credo those days. The name of the game was CP/M 80/86, a86,=20
d86 and ddt ;-)

But let=B4s get serious again.

Your proposed change of the patch results in a 21 ms performance=20
decrease on my system.
Yes, I do know that this is hard to believe. I tested a similar=20
variation before, and the results
were even worse.

Avoiding mul is a good idea in assembly language today, but often it is=20
better to write a
multiplication  with the loop counter in C and not to introduce an extra=20
variable instead. The
compiler will optimize the code and it=B4s easier for gcc without that=20
extra variable.

More interesting would be the question what should be done for idx=3D=3D2=
 or=20
idx=3D=3D3. Probably
fb_pad_aligned_buffer() is also slower for those cases. But does anybody=20
use such fonts?

cu,
 knut


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
