From: Pawel Osciak <p.osciak@samsung.com>
Date: Tue, 01 Jun 2010 06:49:07 +0000
Subject: RE: [PATCH 2/6] s3c-fb: Correct FRAMESEL1 bitfield defines for
Message-Id: <000e01cb0156$886ed050$994c70f0$%osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1275296935-2693-1-git-send-email-p.osciak@samsung.com>
	<1275296935-2693-3-git-send-email-p.osciak@samsung.com>
	<20100601041713.GC30276@trinity.fluff.org>
In-Reply-To: <20100601041713.GC30276@trinity.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>Ben Dooks <ben@trinity.fluff.org> wrote:
>
>On Mon, May 31, 2010 at 11:08:51AM +0200, Pawel Osciak wrote:
>> FRAMESEL1 bitfield starts on 13th bit, not on 14th.
>
>is this true for all variants that have FRAMESEL1?

That's at least the case for all the chips I have docs for:
6400, 6410, S5PC100 and V210...

Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center


