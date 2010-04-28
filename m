From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Date: Wed, 28 Apr 2010 21:16:51 +0000
Subject: Re: [PATCH 3/4] s3c2410fb: correct sections
Message-Id: <87och3gtvg.fsf@lechat.rtp-net.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272450305-7284-1-git-send-email-henne@nachtwindheim.de>
	<1272450305-7284-3-git-send-email-henne@nachtwindheim.de>
In-Reply-To: <1272450305-7284-3-git-send-email-henne@nachtwindheim.de> (Henrik Kretzschmar's message of "Wed\, 28 Apr 2010 12\:25\:04 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Kretzschmar <henne@nachtwindheim.de>
Cc: linux-fbdev@vger.kernel.org, ralf@linux-mips.org, jayakumar.lkml@gmail.com, gregkh@suse.de, yuasa@linux-mips.org, lethal@linux-sh.org, akpm@linux-foundation.org, adobriyan@gmail.com, support@simtec.co.uk, ben@simtec.co.uk, linux@simtec.co.uk, jkosina@suse.cz, pjones@redhat.com, linux-kernel@vger.kernel.org

Henrik Kretzschmar <henne@nachtwindheim.de> writes:

> Since the drivers probe calls were changed from .init.text
> to .devinit.text in commit c2e13037e6794bd0d9de3f9ecabf5615f15c160b
> all the function from .init.text should be moved to .devinit.text, too.
>
> The drivers remove calls can also be move from .text to .devexit.text.

Build tested and booted on my h1940 with current git head
(1d16b0f2f3edf05f12a9e3960588e0d4854157bb).

Acked-by: Arnaud Patard <arnaud.patard@rtp-net.org>
