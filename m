From: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
Subject: RE: [Linux-fbdev-devel] Current discussion about the future of free software graphics
Date: Mon, 10 May 2004 17:11:01 -0700
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <A98078D7EF5BEA4D8D8FD797FFBBC75F0742A3A6@fmsmsx402.fm.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, xserver@freedesktop.org, mesa3d-dev@lists.sourceforge.net, dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net


>It does, or the ioctl must verify the register data, which could =
require
>about the same amount of code as computing it in the kernel in the =
first
>place (possibly even more; the problem changes from computing a valid
>combination of register values for a specific requested mode to =
limiting
>the huge number of register value combinations to those that don't lock
>up the chip or worse). I've pointed this out several times before, but
>nobody has presented a solution yet. Will the userspace code live in a
>daemon that runs as root? Or will only privileged processes be allowed
>to change display properties?

I am in agreement with Michel on this point.
There is a privilege problem.
Either you trust the data coming from user-space to kernel-space
implicitly which means the user-space process now must be privileged,
or you don't trust user-space and you have to re-validate the data =
coming
into the kernel.
The former doesn't buy you much. Now you have another root running =
deamon
floating around to be a security problem.
The latter's protocol and re-validation is difficult to the point of =
being
a complete waste of effort.

I have conceded that I am fine with a user-space mode setting API
as long as there is no imposed user/kernel split. For those who's chips
would require too much code to revalidate, they can just put the whole
mode setting in the kernel. I think we will discover that many of the
more advanced drivers will end up taking this route.

In the end I think this design is more complicated than is necessary. =
The
end goal should be to minimize privileged code, not just kernel code. =
When
you go with a split design you are forcing more privileged code than if
all the code lived in the same place.



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
