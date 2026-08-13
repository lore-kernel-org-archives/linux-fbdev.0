Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEFF38D686;
	Thu, 13 Aug 2026 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663791; cv=none; b=RmavO9fRigs5p8NhE12gTiuMKMMUq7cVqt1ABU+qq8yYPEDWcB4D/VT3Gv7sVSZ5d3BYivTogTP3+/hPvRTs6f+S04QnP7ZkjXzHxabPmud/CWV/IjAacvm6kokmGISmzXYvqetlWOQp/IdbkSp0Vw1uOE05WUqqFdW7tRMncj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663791; c=relaxed/simple;
	bh=3ePxLVPcPol415C1jnd1hRZRwQhV9rEvK2AN1A1AD1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6qvYeUCgeVhKXhUB5V76S9gK4fB+OZ3j7EJmD4Db8ZkVvWUvNS4JtwY74ApUpD+qIxyN/gERLVmuCdpkTxuwpm8bChCPK0WRW0xz91zd150zFJW7c7Rw3FK8w83imOLUzA3n2mlLWoI1mURHWYnvXErU41jpAz0eONsVW0yN5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CKNQB5db; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CKNQB5db"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4xDOoRVfx4DzTe1p1zmU0BCJRCQhsbwPhmZYGCEo7Dg=; b=CKNQB5dbietwRWYGnEJplufeND
	6fg68c0A8zHOHSD2Rle7OXJHTDVoPwTLIb2pCDOMEjxVKBETckJOHx+c4MQxAMTpVo96JsQ5T7TcV
	hSrZ1ege1948UGOGXLA6p1dS36pZTPPbaF2H9tCBL1vZ0flrwQ96K0yr+BS70QQ1zexZYrNoqxEXP
	4rwcQJpldAbqcd8OVJxf9wBUqpCD725VML3eHW7uEoTnL4rs9hhBYGGU9c8R1kWRHsub4AMJ8FI4N
	2EcTE182D2mh6Y2bd0B/a0ptjppUOVEZzyFBhVZKW7Al4QgNKAf2eUOwLB4gvR9Akq6gVghedMZ06
	09dlHU/g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuerf-00000001k8D-05B9;
	Thu, 13 Aug 2026 23:29:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 00/03] fbdev: maxine: clean up build issues
Date: Thu, 13 Aug 2026 16:29:31 -0700
Message-ID: <20260813232934.2718291-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is all ancient source code from the beginning of git time.
Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.


Subject: [PATCH 01/03] fbdev: maxine: make functions static
Subject: [PATCH 02/03] fbdev: maxine: elide an unused function
Subject: [PATCH 03/03] fbdev: maxine: fix 64-bit build error

 drivers/video/fbdev/maxinefb.c |    9 ++++++---
 include/video/maxinefb.h       |    4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
