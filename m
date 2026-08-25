Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296353DEFFB
	for <linux-fbdev@vger.kernel.org>; Tue, 25 Aug 2026 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648505; cv=none; b=PE2v/XxKm+SB/g7KoMzVZUWHjgsKaRThA2oNwwddjnL9WZkgBj0UO54WfDTM04FqM4Ot5J/m+ROGrm5OCAUbGIBIwE4FIWcoqKoDobsb4ob7Vb1iAoLUfTwuQbGRbTtBDjbRMlzkY6nORoT1FcyCFkgf9dbqfUU9QM8pQA8jAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648505; c=relaxed/simple;
	bh=JDeOtktzhn1YnwIXwKUItM0FpMKTl5zt0iy1WfoKZwc=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=giK/JBglV6NfGU8XAyQ1u/KEER2baaGn+gLy0VGHAD65a5d6qhzhZKdkfEE841Vm2VYPtKpznsOnQKGG0jFhngKVwSjCXomfoA/cr3o1jAGVqWcfZ6qKB3LBiuePAQ5cXU8jBMVSf06hVfvpnvVWnlFpVbWr9S9O7i/rW6O9mDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.160.162])
	by mtasvr (Coremail) with SMTP id _____wBnIz7vWY1qnGHBAA--.8796S3;
	Tue, 25 Aug 2026 17:01:36 +0800 (CST)
Received: from stitch$zju.edu.cn ( [10.190.160.162] ) by
 ajax-webmail-mail-app1 (Coremail) ; Tue, 25 Aug 2026 17:01:35 +0800
 (GMT+08:00)
Date: Tue, 25 Aug 2026 17:01:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Jiacheng Xu" <stitch@zju.edu.cn>
To: "Helge Deller" <deller@gmx.de>
Cc: "Thomas Zimmermann" <tzimmermann@suse.de>,
	"Simona Vetter" <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [BUG] fbcon rotate causes vmalloc out-of-bounds write after
 vc_resize failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2025.3-cmXT6 build
 20260617(6f868824) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3394ce6f.1a32a.1a038275127.Coremail.stitch@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yy_KCgBna6XvWY1qDOQfBA--.253W
X-CM-SenderInfo: qtrxiiaqttimo62m3hxhgxhubq/1tbiAwIOC2qM9pcD3gAIsW
X-CM-DELIVERINFO: =?B?4OA/dgXKKxbFmtjJiESix3B1w3tMoM3snk/k5SVzZVydjEqe1eefKHnLf95EnB4iem
	egW4fQsIcz6umLz5CG6CW/IDVkXbfswUu/snLUb/yfw5mXYdc4lBcSWCVKpGWZ2M2SVveQ
	K57+AxbK/SWT+FN7GtjFiwxosi0UcqwN5P5z7xdrBhTU/BR6fnxaHQBb+sK+Yw==
X-Coremail-Antispam: 1Uk129KBj93XoW7CryxZw4kKw15ZFyUXr45XFc_yoW8XF18pr
	90yFW7KF1kAryUAwn7JayfZa40va1DXr1jgrWDKw18Kas8Gan2qFyfK3WrWayxCFnxGw45
	AF4jyFyDC3y5AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa
	7IU86OJ7UUUUU==

RXhlY3V0aW9uIGVudmlyb25tZW50OgoKLSBLZXJuZWw6IExpbnV4IGNvbW1pdCAwZjIzZDU2Zgot
IEFyY2hpdGVjdHVyZTogeDg2XzY0Ci0gUUVNVTogS1ZNLWVuYWJsZWQgcWVtdS1zeXN0ZW0teDg2
XzY0Ci0gR3Vlc3QgaW1hZ2U6IERlYmlhbiBCdWxsc2V5ZQotIEtBU0FOIGFuZCBmYXVsdCBpbmpl
Y3Rpb24gZW5hYmxlZAoKClRoZSBrZXJuZWwgd2FzIHN0YXJ0ZWQgd2l0aDoKCnFlbXUtc3lzdGVt
LXg4Nl82NCBcCiAgICAtbSAyRyBcCiAgICAtc21wIDIgXAogICAgLWtlcm5lbCAuL2J6SW1hZ2Ug
XAogICAgLWFwcGVuZCAiY29uc29sZT10dHlTMCByb290PS9kZXYvc2RhIGVhcmx5cHJpbnRrPXNl
cmlhbCBuZXQuaWZuYW1lcz0wIiBcCiAgICAtZHJpdmUgZmlsZT0uL2J1bGxzZXllLmltZyxmb3Jt
YXQ9cmF3IFwKICAgIC1uZXQgdXNlcixob3N0PTEwLjAuMi4xMCxob3N0ZndkPXRjcDoxMjcuMC4w
LjE6MTAwMjEtOjIyIFwKICAgIC1uZXQgbmljLG1vZGVsPWUxMDAwIFwKICAgIC1lbmFibGUta3Zt
IFwKICAgIC1ub2dyYXBoaWMgXAogICAgLXBpZGZpbGUgdm0ucGlkIFwKICAgIDI+JjEgfCB0ZWUg
dm0ubG9nCgoKVHJpZ2dlciBjb25kaXRpb246CgoxLiBXcml0ZSB0byBgL3N5cy9jbGFzcy9ncmFw
aGljcy9mYmNvbi9yb3RhdGVgIHRvIGluaXRpYWxpemUgdGhlIGF0dHJpYnV0ZS4KMi4gU2V0IHRo
ZSBjdXJyZW50IHRocmVhZCdzIGZhdWx0LWluamVjdGlvbiBjb3VudGVyIHRvIDEzIHRocm91Z2gK
ICAgIGAvcHJvYy90aHJlYWQtc2VsZi9mYWlsLW50aGAuCjMuIFJlcXVlc3Qgcm90YXRpb24gdmFs
dWUgMSB0aHJvdWdoIHRoZSBzYW1lIGByb3RhdGVgIGF0dHJpYnV0ZS4KClRoZSBpbmplY3RlZCBm
YWlsdXJlIG9jY3VycyBkdXJpbmcgbWVtb3J5IGFsbG9jYXRpb24gaW4gdmNfZG9fcmVzaXplKCku
IFRoZSBzdWJzZXF1ZW50IHJlZHJhdyBwYXRoIHJlYWNoZXMgc3lzX2ltYWdlYmxpdCgpIGFuZCBy
ZXBvcnRzIGEgS0FTQU4gdm1hbGxvYyBvdXQtb2YtYm91bmRzIHdyaXRlLgoKClBvdGVudGlhbCBy
b290IGNhdXNlOgoKZmJjb25fbW9kZWNoYW5nZWQoKSBzd2l0Y2hlcyB0byB0aGUgbmV3IHJvdGF0
aW9uIGFuZCBibGl0dGluZyBvcGVyYXRpb25zIGJlZm9yZSByZXNpemluZyB0aGUgdmlydHVhbCBj
b25zb2xlLiBXaGVuIHZjX3Jlc2l6ZSgpIGZhaWxzLCBpdHMKcmV0dXJuIHZhbHVlIGlzIGlnbm9y
ZWQgYW5kIHVwZGF0ZV9zY3JlZW4oKSBzdGlsbCBydW5zLgoKQXMgYSByZXN1bHQsIHRoZSBWVCBn
ZW9tZXRyeSBhbmQgc2NyZWVuIGJ1ZmZlciByZW1haW4gaW4gdGhlIG9sZCBzdGF0ZSB3aGlsZSB0
aGUgZnJhbWVidWZmZXIgY29uc29sZSB1c2VzIHRoZSBuZXcgcm90YXRpb24gc3RhdGUuCnN5c19p
bWFnZWJsaXQoKSB0aGVuIGNhbGN1bGF0ZXMgYW4gaW52YWxpZCBmcmFtZWJ1ZmZlciBhZGRyZXNz
IGFuZCBwZXJmb3JtcyBhbiBvdXQtb2YtYm91bmRzIHdyaXRlLgoKQmVzdCwKSmlhY2hlbmcKCg==

