From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 02 Jul 2010 13:05:20 +0000
Subject: RE: [PATCH v3 03/12] s3c-fb: Separate S5PC100 and S5PV210 framebuffer
Message-Id: <003d01cb19e7$39c7db50$ad5791f0$%osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-4-git-send-email-p.osciak@samsung.com>
	<4C2DC986.7040705@simtec.co.uk>
In-Reply-To: <4C2DC986.7040705@simtec.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> Ben Dooks <ben@simtec.co.uk> wrote:
>On 28/06/10 09:08, Pawel Osciak wrote:
>> S5PC100 and S5PV210 framebuffer devices differ slightly in terms of
>> available registers and their driver data structures have to be separate.
>
>Would have been nice to note which ones changes, otherwise ok.

For this series, the difference is the existence of PRTCON and SHADOWCON
registers. There are more AFAIR. I am not sure if it'd be a good place
to list all of them though...

Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center





